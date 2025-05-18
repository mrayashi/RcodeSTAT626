library(rstan)
y <- 3
stan_data <- list(N = 10, y = y)
fit <- stan(file = "binomial_model2.stan", data = stan_data, iter = 2000, chains = 4)
print(fit)


library(rstan)
y <- c(3.2,-1.2,5.6,6.2,3.5)
stan_data <- list(N = length(y), y = y)
fit <- stan(file = "model3.stan", data = stan_data, iter = 2000, chains = 4)
print(fit)


library(rstan)
y <- c(0,3,1,4,5,3,1,0,4)
stan_data <- list(N = length(y), y = y)
fit <- stan(file = "model5.stan", data = stan_data, iter = 2000, chains = 4)
print(fit)



library(rstan)

stan_data <- list(N1 = 100, N2=130, y1 = 10, y2=23)
fit <- stan(file = "model9.stan", data = stan_data, iter = 2000, chains = 4)
print(fit)




library(rstan)
y<-c(1,1,1,1,1,1,0,0,0,0)
stan_data <- list(N=length(y),y=y)
fit <- stan(file = "model_ex31.stan", data = stan_data, iter = 2000, chains = 4)
print(fit)


library(rstan)
y<-c(10.5, 11.2, 9.8, 10.1, 10.3, 10.8, 11.0, 10.7, 10.4, 10.6)
stan_data <- list(N=length(y),y=y, sigma=1.5)
fit <- stan(file = "model_ex33.stan", data = stan_data, iter = 2000, chains = 4)
print(fit)


library(rstan)
set.seed(123)
y1<-c(10.2,11.5,13.2,10.1,9.8)
y2<-c(9.3,13.2,14.1,10.5,11.3)
stan_data <- list(N=length(y1),y1=y1, y2=y2,sigma=1.5)
fit <- stan(file = "comparemeans.stan", data = stan_data, iter = 4000, chains = 4)
print(fit)
