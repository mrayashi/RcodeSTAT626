data {
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
