y<-c(1,1,1,0,1,0,0,0,0,1,1,1)
N<-length(y)

stan_data <- list(y = y, N = N)


library(rstan)

fit<-stan(file='bernoulli_model.stan', data=stan_data, iter=1000, chains=1)

summary(fit)


y<-c(3,0,6,3,10,9)
N<-length(y)

stan_data <- list(y = y, N = N, n=10)


library(rstan)

fit<-stan(file='binomial_model.stan', data=stan_data, iter=1000, chains=1)
fit
summary(fit)



y<-c(3,0,6,3,10,9)
N<-length(y)

stan_data <- list(y = y, N = N, n=10)


library(rstan)

fit<-stan(file='poisson_model.stan', data=stan_data, iter=1000, chains=1)
fit
summary(fit)


stan_data <- list(y = x, N = length(x))


library(rstan)

fit<-stan(file='normal_model.stan', data=stan_data, iter=3000, chains=2)
fit
summary(fit)

##




### 
xD<-decathlon$`100m`[decathlon$Competition=="Decastar"]
xD

xO<-decathlon$`100m`[decathlon$Competition=="OlympicG"]
xO

mean(xD)
mean(xO)
t.test(xD,xO,paired = F,var.equal = T,alternative = "greater")

stan_data <- list(yD = xD, nD = length(xD), yO = xO, nO = length(xO))

fit<-stan(file='diff_normal.stan', data=stan_data, iter=3000, chains=2)
fit
summary(fit)


# Load the Titanic data and convert to a data frame
titanic_data <- as.data.frame(Titanic)

# Aggregate data to find the total and survived counts by Sex
library(dplyr)

# Total passengers by Sex
total_by_sex <- titanic_data %>%
  group_by(Sex) %>%
  summarise(Total = sum(Freq))

# Survivors by Sex
survivors_by_sex <- titanic_data %>%
  filter(Survived == "Yes") %>%
  group_by(Sex) %>%
  summarise(Survived = sum(Freq))

# Join the data to calculate survival probabilities
survival_data <- left_join(total_by_sex, survivors_by_sex, by = "Sex")

# Calculate the probability of survival
survival_data <- survival_data %>%
  mutate(Survival_Probability = Survived / Total)

# Print the results
print(survival_data)

prop.test(survivors_by_sex$Survived, total_by_sex$Total, alternative = "less")

stan_data<-list(yF=survivors_by_sex$Survived[2], nF=total_by_sex$Total[2],
                yM=survivors_by_sex$Survived[1], nM=total_by_sex$Total[1])


fit<-stan(file='diff_prop.stan', data=stan_data, iter=3000, chains=2)
fit
summary(fit)