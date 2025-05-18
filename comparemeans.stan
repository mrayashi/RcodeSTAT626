data {
  int<lower=0> N;
  real y1[N];
  real y2[N];
  real<lower=0> sigma;
}

parameters {
  real mu1;
  real mu2;
}

transformed parameters {
  real delta;
  delta = mu1-mu2;
}

model {
  mu1 ~ normal(0,1);
  mu2 ~ normal(0,2);
  y1 ~ normal(mu1,sigma);
  y2 ~ normal(mu2,sigma);
}