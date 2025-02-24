data {
  int<lower=0> N;
  real y[N];
}

parameters {
  real mu;
  real<lower=0> sigma;
}

model {
  // Non-informative prior for mu
  mu ~ normal(0, 1000); // You may adjust this if you wish

  // Weakly informative/non-informative Gamma prior for sigma
  sigma ~ gamma(0.01, 0.01);

  // Likelihood
  y ~ normal(mu, sigma);
}
