data {
 int<lower=0> N;
 real y[N];
}

parameters {
  real mu;
  real<lower=0> sigma;
}

model {
  mu ~ normal(5,10);
  sigma ~ inv_gamma(2,1);
  y ~ normal(mu, sigma);
}