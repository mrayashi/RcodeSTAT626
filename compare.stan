data {
int < lower =0> N1; // Number of Experiment
int < lower =0> N2; // Number of placebo
int < lower =0, upper =1> y1[N1]; // Binary outcomes experiment
int < lower =0, upper =1> y2[N2]; // Binary outcomes placebo
}
parameters {
real < lower =0, upper =1> p1; // Probability of success experiment
real < lower =0, upper =1> p2; // Probability of success placebo
}
model {
p1 ~ beta(1, 1); // Uniform prior experiment
p2 ~ beta(1, 1); // Uniform prior
y1 ~ bernoulli(p1); // Likelihood
y2 ~ bernoulli(p2); // Likelihood
}
