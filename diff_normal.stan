data {
  int<lower=0> nD;  // number of observations for group D
  int<lower=0> nO;  // number of observations for group O
  vector[nD] yD;    // outcomes for group D
  vector[nO] yO;    // outcomes for group O
}

parameters {
  real muD;
  real<lower=0> sigmaD;
  real muO;
  real<lower=0> sigmaO;
}

transformed parameters {
  real delta;
  delta = muD - muO; // Difference in means
}

model {
  // Priors
  muD ~ normal(0, 100);
  muO ~ normal(0, 100);
  sigmaD ~ gamma(0.01, 0.01);
  sigmaO ~ gamma(0.01, 0.01);

  // Likelihood
  yD ~ normal(muD, sigmaD);
  yO ~ normal(muO, sigmaO);
}
