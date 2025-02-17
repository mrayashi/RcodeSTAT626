library(rstan)
y <- c(1, 0, 1, 1, 0, 1, 1, 1, 0, 1)
stan_data <- list (N = length(y), y=y)
fit <- stan(file = "bernoulli_model.stan",
              data = stan_data ,
              iter = 1000 , chains = 2)
print(fit) # Summary of posterior
plot ( fit )

fit1 <- stan(file = "bernoulli_model.stan",
            data = stan_data ,
            iter = 1000 , chains = 2)
print(fit1) # Summary of posterior

f<-function(x) dbeta(x,15,5)

curve(f,0,1,add=TRUE,col="red")

samples<-c(fit@sim$samples[[1]][[1]],fit@sim$samples[[2]][[1]])
posterion<-


print(fit1)

samples1<-c(fit1@sim$samples[[1]][[1]],fit1@sim$samples[[2]][[1]])

plot(density(samples1),col="blue")

f1<-function(x) dbeta(x,1,1)

curve(f1,0,1,add=TRUE,col="red")
