data {
  int<lower=0> N;
  int<lower=0, upper=1> y[N];
}

parameters {
  real<lower=0, upper=1> p;
}

model {
p ~ beta(2,2);
y ~ bernoulli(p);
}