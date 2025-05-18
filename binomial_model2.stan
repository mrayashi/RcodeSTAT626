
// The input data is a vector 'y' of length 'N'.
data {
  int<lower=0> N;
  int<lower=0, upper=N> y ;
}

// The parameters accepted by the model. Our model
// accepts two parameters 'mu' and 'sigma'.
parameters {
  real<lower=0, upper=1> p;
}

// The model to be estimated. We model the output
// 'y' to be normally distributed with mean 'mu'
// and standard deviation 'sigma'.
model {
  y ~ binomial(N,p);
  p ~ beta(1,1);
}

