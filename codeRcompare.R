library(rstan)
y1 <- c(1, 0, 0,1,1,0,1)
y2 <- c(0,1,0,0,0,1,1,1)
stan_data <- list(N1 = length(y1), y1 = y1, N2=length(y2),y2=y2)
fit <- stan(file = "compare.stan", data = stan_data,
            iter = 2000, chains = 4)
print(fit)

sample_p1<-c(fit@sim$samples[[1]][[1]],
             fit@sim$samples[[2]][[1]],
             fit@sim$samples[[3]][[1]],
             fit@sim$samples[[4]][[1]])

sample_p2<-c(fit@sim$samples[[1]][[2]],
             fit@sim$samples[[2]][[2]],
             fit@sim$samples[[3]][[2]],
             fit@sim$samples[[4]][[2]])
mean(sample_p1)

quantile(sample_p1, c(0.025,0.25,0.5,.75, 0.975))

mean(sample_p2)

quantile(sample_p2, c(0.025,0.25,0.5,.75, 0.975))


delta<-sample_p1-sample_p2

mean(delta>0)
