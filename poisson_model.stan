data {
  int<lower=0> N;  // sample size
  int<lower=0> y[N];  // number of successes
}

parameters {
  real<lower=0> lambda;  // probability of success
}

model {
  // Prior distribution for p
  lambda ~ gamma(2, 2);  // 

  // Likelihood of the data given p
  y ~ poisson(lambda);
}
