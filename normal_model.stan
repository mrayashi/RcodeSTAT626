data {
    int<lower=0> N;          // Number of observations
    real y[N];               // Data
}

parameters {
    real mu;                 // Mean
    real<lower=0> sigma2;    // Variance
}

model {
    mu ~ normal(5.0, sqrt(sigma2));   // Prior for mu
    sigma2 ~ inv_gamma(2, 1);         // Prior for sigma2
    y ~ normal(mu, sqrt(sigma2));     // Likelihood
}