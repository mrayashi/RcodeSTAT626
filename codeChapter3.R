library(rstan)


# Model 1: Standard Beta-Binomial
model_code_standard <- "
data {
  int<lower=0> n;
  int<lower=0> y;
}
parameters {
  real<lower=0, upper=1> theta;
}
model {
  theta ~ beta(2, 1);
  y ~ binomial(n, theta);
}
"

# Model 2: Non-identifiable Beta-Binomial
model_code_nonid <- "
data {
  int<lower=0> n;
  int<lower=0> y;
}
parameters {
  real<lower=0,upper=0.5> theta1;
  real<lower=0,upper=0.5> theta2;
}
model {
  theta1 ~ beta(2, 2);
  theta2 ~ beta(2, 2);
  y ~ binomial(n, theta1 + theta2);
}
"

data_list <- list(n = 36, y = 29)

# Fit the standard model
fit_standard <- stan(model_code = model_code_standard, 
                     data = data_list,
                     chains = 4, iter = 2000, warmup = 1000, seed = 123)

# Fit the non-identifiable model
fit_nonid <- stan(model_code = model_code_nonid, 
                  data = data_list,
                  chains = 4, iter = 2000, warmup = 1000, seed = 123)

# Print summaries
print(fit_standard)
print(fit_nonid)


library(bayesplot)
mcmc_trace(as.array(fit_standard), pars = "theta")
mcmc_trace(as.array(fit_nonid), pars = "theta1")
mcmc_trace(as.array(fit_nonid), pars = "theta2")
library(ggmcmc)
ggs_traceplot(ggs(fit_standard))+theme_bw()
ggs_traceplot(ggs(fit_standard))+theme_bw()
ggs_traceplot(ggs(fit_nonid),family = 'theta1')+theme_bw()
ggs_traceplot(ggs(fit_nonid),family = 'theta2')+theme_bw()

library(bayesplot)
mcmc_dens_overlay(as.array(fit_standard), pars = "theta")
mcmc_dens_overlay(as.array(fit_nonid), pars = c("theta1","theta2"))
library(ggmcmc)
ggs_density(ggs(fit_standard))+theme_bw()
ggs_density(ggs(fit_nonid),family = 'theta1')+theme_bw()
ggs_density(ggs(fit_nonid),family = 'theta2')+theme_bw()


library(bayesplot)
mcmc_acf(as.array(fit_standard), lags = 10,pars = 'theta')
mcmc_acf(as.array(fit_nonid), lags = 10,pars = c('theta1','theta2'))
library(ggmcmc)
ggs_autocorrelation(ggs(fit_standard),nLags = 10)+theme_bw()
ggs_autocorrelation(ggs(fit_nonid),family = 'theta1',nLags = 10)+theme_bw()
ggs_autocorrelation(ggs(fit_nonid),family = 'theta2',nLags = 10)+theme_bw()

library(ggmcmc)
ggs_Rhat(ggs(fit_standard),family = 'theta')+theme_bw()
ggs_Rhat(ggs(fit_nonid))


fit <- stan( model_code = model_code_standard, data = data_list,
            chains = 4, iter = 2000, warmup = 1000, seed = 123,
            control = list(stepsize = 0.01,  # Try smaller or larger values
                           adapt_delta = 0.95,  # Target acceptance probability
                           max_treedepth = 15)) # Maximum tree depth in NUTS
print(fit)


ggs_object <- ggs(fit_standard)
ggs_object
ggs_effective(ggs_object)+theme_bw()
ggs_Rhat(ggs_object)+theme_bw()
ggs_traceplot(ggs_object)+theme_bw()
ggs_density(ggs_object)+theme_bw()
ggs_autocorrelation(ggs_object)+theme_bw()
ggs_pairs(ggs_object)+theme_bw()

ggs_object_noind <- ggs(fit_nonid)
ggs_pairs(ggs_object_noind)+theme_bw()
ggs_effective(ggs_object_noind)+theme_bw()
ggs_Rhat(ggs_object_noind)+theme_bw()


library(coda)
sims_list <- sapply(1:4, function(i) {
  mcmc(fit_standard@sim$samples[[i]][[1]])
})


chains <- mcmc.list(sims_list)
heid <- heidel.diag(sims_list, eps=0.1, pvalue=0.05)
heid


ggs_geweke(ggs_object)+theme_bw()

x<-ggs_geweke(ggs_object)
x$data

## Confidence intervals of the parameters
ggs_caterpillar(ggs_object)+theme_bw()
ggs_caterpillar(ggs_object_noind)+theme_bw()


## LOOIC and WAIC

library(loo)
# Extract log-likelihood from a fitted Stan model
log_lik <- extract_log_lik(fit_standard,parameter_name = 'theta')
# Compute LOOIC
loo_result <- loo(log_lik)
print(loo_result)
plot(loo_result)


##


# Calculate the deviance for each posterior draw
deviance <- -2 * log_lik

# Compute the posterior mean of the deviance
D_bar <- mean(deviance)

# Calculate the deviance at the posterior mean of the parameters
# For example, assuming a binomial likelihood:
theta_bar <- mean(unlist(sims_list))
D_theta_bar <- -2 * sum(dbinom(data_list$y, size = data_list$n, 
                               prob = theta_bar, log = TRUE))

# Compute the effective number of parameters
pD <- D_bar - D_theta_bar

# Finally, compute the DIC
DIC <- D_bar + pD

# Print the DIC value
cat("DIC:", DIC, "\n")

# Extract log-likelihood from a fitted Stan model
log_lik1 <- extract_log_lik(fit_nonid,parameter_name = 'theta1')
# Compute LOOIC
loo_result1 <- loo(log_lik1)
print(loo_result1)

# Extract log-likelihood from a fitted Stan model
log_lik2 <- extract_log_lik(fit_nonid,parameter_name = 'theta2')
# Compute LOOIC
loo_result2 <- loo(log_lik2)
print(loo_result2)

# Compute WAIC
waic_result <- waic(log_lik)
print(waic_result)

waic_result1 <- waic(log_lik1)
print(waic_result1)

waic_result2 <- waic(log_lik2)
print(waic_result2)
