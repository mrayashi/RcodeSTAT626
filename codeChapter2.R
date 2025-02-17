# Simulation and Comparison in R (Bernoulli Distribution):
n <- 1000  
p <- 0.3  
set.seed(123)  
samples <- rbinom(n, 1, p)  
emp_probs <- table(samples)/n  
theoretical <- c(0.7, 0.3)
barplot(rbind(theoretical, emp_probs),
        beside = TRUE,
        col = c("red", "blue"),
        main = "PMF Comparison")
plot(stepfun(c(0,1), c(0,0.7,1)),
     main = "CDF Comparison",
     xlim = c(-0.5,1.5))
lines(ecdf(samples),
      col = 'blue', lty = 2)


# Activity: Simulating Disease Transmission:
set.seed(456)
p_infect <- 0.15
n_students <- 500
infected <- rbinom(n_students, 1, p_infect)
n_infected <- sum(infected)
attack_rate <- mean(infected)
barplot(c(Theoretical = p_infect,
          Observed = attack_rate),
        ylab = "Probability",
        col = c("red3", "dodgerblue"),
        main = "Infection Risk Comparison")
prop.test(n_infected, n_students)
p_new_variant <- 0.30
infected_new <- rbinom(n_students, 1, p_new_variant)

# Vaccine Efficacy (VE):

p_control <- 0.25
p_var <- 0.05
ve <- 1 - (p_var/p_control)
p <- 0.5
e <- 0.02
n <- (qnorm(0.975)^2 * p*(1-p)) / e^2

# Simulation and Comparison in R (Binomial Distribution):

n_trials <- 1000  
n <- 100    
p <- 0.05    
set.seed(123)  
infections <- rbinom(n_trials, n, p)  
k <- 0:n  
pmf <- dbinom(k, n, p)  
mean(infections)  
var(infections)  
hist(infections, freq=FALSE,
     main = "Infection Distribution",
     xlab = "Number of Cases")
lines(k, pmf, col="red", lwd=2)
plot(ecdf(infections),
     main = "CDF Comparison")
lines(k, pbinom(k, n, p),
      col="red", type="s")


# Simulation and Comparison in R (Poisson Distribution):
lambda <- 4  
n_samples <- 1000  
set.seed(123)  
particles <- rpois(n_samples, lambda)  
k <- 0:15  
pmf <- dpois(k, lambda)  
mean(particles)  
var(particles)  
mean(particles==0)  
exp(-lambda)  
hist(particles, freq=FALSE, breaks=0:15,
     main = "Microplastic Particles/Litter",
     xlab = "Count")
points(k, pmf, col="red", pch=19)
plot(particles[1:50], type="b",
     main = "Particle Count Time Series",
     xlab = "Sample ID", ylab = "Count",
     col = "darkgreen")
abline(h = lambda, col="red", lty=2)

# Activity: Pollution Hotspot Analysis:

lambda_ds <- 8
lambda_us <- 3
samples <- 500
set.seed(456)
ds_counts <- rpois(samples, lambda_ds)
us_counts <- rpois(samples, lambda_us)

# Simulation and Comparison in R (Negative Binomial Distribution):

mu <- 3    
theta <- 2 
n <- 1000  
set.seed(2023)  
visits <- rnbinom(n, mu=mu, size=theta)  

visits <- rpois(n,mu)
k <- 0:15  
pmf <- dnbinom(k, mu=mu, size=theta)  
var(visits)/mean(visits)
hist(visits, freq=FALSE, breaks=0:20,
     main = "Visits Until Conversion",
     xlab = "Website Visits")
lines(k, pmf, col="red", type="h")

qqplot(rpois(1000, mu), visits,
       main = "NB vs Poisson QQ-Plot")
abline(0,1, col="red")

# Simulation and Comparison in R (Normal Distribution):

mu <- 100  
sigma <- 15  
n <- 1000  
set.seed(123)  
iq_scores <- rnorm(n, mu, sigma)  
x <- seq(55, 145, length=100)  
pdf <- dnorm(x, mu, sigma)  
mean(iq_scores)  
sd(iq_scores)  
shapiro.test(iq_scores)
hist(iq_scores, freq=FALSE, breaks=20,
     main = "IQ Score Distribution",
     xlab = "IQ")
lines(x, pdf, col="red", lwd=2)
qqnorm(iq_scores, main = "Normal Q-Q Plot")
qqline(iq_scores, col="red")

# Simulation and Comparison in R (Exponential Distribution):
lambda <- 0.1    
mu <- 1/lambda   
n <- 1000
set.seed(123)
durations <- rexp(n, lambda)
x <- seq(0, 30, length=100)
pdf <- dexp(x, lambda)
mean(durations)
var(durations)
hist(durations, freq=FALSE, breaks=30,
     main = "Time Between Intrusions",
     xlab = "Days")
lines(x,pdf, col="red", lwd=2)
plot(ecdf(durations),
     main = "CDF Comparison")
lines(x, pexp(x, lambda),
      col="red", lwd=2)

# Simulation and Comparison in R (Gamma Distribution):

shape <- 2  
scale <- 2.5  
n <- 1000  
set.seed(123)  
stays <- rgamma(n, shape=shape, scale=scale)
x <- seq(0, 20, length=100)  
pdf <- dgamma(x, shape=shape, scale=scale)
mean(stays)  
var(stays)  
moments::skewness(stays)
hist(stays, freq=FALSE, breaks=30,
     main = "Hospital Stay Duration",
     xlab = "Days", col="lightblue")
lines(x, pdf, col="maroon", lwd=2)
legend("topright",
       legend=c("Theory","Empirical"),
       col=c("maroon","lightblue"), lwd=2)
plot(ecdf(stays),
     main="Empirical vs Theoretical CDF")
lines(x, pgamma(x, shape=shape, scale=scale),
      col="darkgreen", lwd=2)

# Simulation and Comparison in R (Beta Distribution):

alpha <- 46  
beta <- 956  
n <- 10000  
set.seed(123)  
rates <- rbeta(n, alpha, beta)  
x <- seq(0, 0.1, length=100)  
pdf <- dbeta(x, alpha, beta)  
mean(rates)  
quantile(rates, c(0.025,0.975))
hist(rates, freq=FALSE, breaks=50,
     main = "Conversion Rate Distribution",
     xlab = "Conversion Rate", col="skyblue")
lines(x, pdf, col="darkred", lwd=2)
plot(ecdf(rates), main="Beta CDF Comparison")
lines(x, pbeta(x, alpha, beta),
      col="darkgreen", lwd=2)

# Example: Analytical Solution (Bernoulli Model):

successes <- 7
failures <- 3
prior_uniform <- c(1, 1)    
prior_weak <- c(2, 2)    
prior_informative <- c(5, 5)    
posterior_uniform <- c(prior_uniform[1] + successes,
                       prior_uniform[2] + failures)
posterior_weak <- c(prior_weak[1] + successes,
                    prior_weak[2] + failures)
posterior_informative <- c(prior_informative[1] + successes,
                           prior_informative[2] + failures)
curve(dbeta(x, posterior_uniform[1], posterior_uniform[2]), xlab="p", ylab="Density", col="blue", lwd=2, ylim=c(0, 4))
curve(dbeta(x, posterior_weak[1], posterior_weak[2]), col="red", lwd=2, add=TRUE)
curve(dbeta(x, posterior_informative[1], posterior_informative[2]), col="green", lwd=2, add=TRUE)
legend("topright", legend=c("Uniform", "Weak", "Informative"), col=c("blue", "red", "green"), lwd=2)

# R Example: Using rstan (Bernoulli Model):

library(rstan)
y <- c(1, 0, 1, 1, 0, 1, 1, 1, 0, 1)
stan_data <- list(N = length(y), y = y)
fit <- stan(file = "bernoulli_model.stan", data = stan_data,
            iter = 2000, chains = 4)
print(fit)
plot(fit)
slotNames(fit)

samples <- fit@sim$samples

all_p_samples <- c(samples[[1]][[1]],samples[[2]][[1]],
                   samples[[3]][[1]],samples[[4]][[1]])

mean(all_p_samples)
quantile(all_p_samples, c(0.025,0.25,.5,.75, 0.975))

log_posterior<-function(p,y){
    s<-sum(y)
    n<-length(y)
   (s+1)*log(p) + (n-s+1)*log(1-p)
}
samples[[1]][[2]][1]
log_posterior(p = samples[[1]][[1]][1],y = y)
# Example: Unknown Mean, Known Variance:

y <- c(5.1, 5.5, 4.9, 5.3, 5.7)    
n <- length(y)
sigma2 <- 0.5    
mu0 <- 5.0    
tau02 <- 1.0    
mu_n <- (mu0/tau02 + n*mean(y)/sigma2) / (1/tau02 + n/sigma2)
tau_n2 <- 1 / (1/tau02 + n/sigma2)

# Example: Unknown Mean and Variance:
y <- c(5.1, 5.5, 4.9, 5.3, 5.7)    
n <- length(y)
mu0 <- 5.0    
kappa0 <- 1    
alpha0 <- 2    
beta0 <- 1    
mu_n <- (kappa0 * mu0 + n * mean(y)) / (kappa0 + n)
kappa_n <- kappa0 + n
alpha_n <- alpha0 + n/2
beta_n <- beta0 + 0.5*sum((y - mean(y))^2) +  
  (kappa0 *n*(mean(y) - mu0)^2)/(2*(kappa0 + n))
curve(dnorm(x, mu_n, sqrt(beta_n / (alpha_n * kappa_n))), xlim=c(4, 6), ylab="Density", col="red", lwd=2, main="Posterior for Mean")

# Using rstan for Unknown Mean and Variance:

library(rstan)
y <- c(5.1, 5.5, 4.9, 5.3, 5.7)
stan_data <- list(N = length(y), y = y)
fit <- stan(file = "normal_model.stan", data = stan_data, iter = 2000, chains = 4)
print(fit)
plot(fit)









