data {
  int<lower=0> N;  // sample size
  int<lower=0> n;
  int<lower=0, upper=n> y[N];  // number of successes
}

parameters {
  real<lower=0, upper=1> p;  // probability of success
}

model {
  // Prior distribution for p
  p ~ beta(2, 2);  // example: Beta(2, 2) prior

  // Likelihood of the data given p
  y ~ binomial(n, p);
}
