data {
<<<<<<< HEAD
int < lower =0> N; // Number of trials
int < lower =0, upper =1> y[N]; // Binary outcomes
}
parameters {
real < lower =0, upper =1> p; // Probability of success
}
model {
p ~ beta(1, 1); // Uniform prior
y ~ bernoulli(p); // Likelihood
}
=======
    int<lower=0> N;          // Number of trials
    int<lower=0, upper=1> y[N];  // Binary outcomes
}

parameters {
    real<lower=0, upper=1> p;  // Probability of success
}

model {
    p ~ beta(1, 1);          // Uniform prior
    y ~ bernoulli(p);        // Likelihood
}
>>>>>>> 0db9f80cda1eb24b0b50dfcfb419987fe728affe
