data {
  int<lower=0> nF;
  int<lower=0> nM;
  int<lower=0,upper=nF> yF;
  int<lower=0,upper=nM> yM;
}

// The parameters accepted by the model. Our model
// accepts two parameters 'mu' and 'sigma'.
parameters {
  real<lower=0,upper=1> pF;
  real<lower=0,upper=1> pM;
}

transformed parameters {
  real delta;
  delta = pF - pM; // Difference in means
  real OR;
  OR = (pM/(1-pM))*((1-pF)/pF);
}

// The model to be estimated. We model the output
// 'y' to be normally distributed with mean 'mu'
// and standard deviation 'sigma'.
model {
  // prior
  pF ~ beta(1,1);
  pM ~ beta(1,1);
  // likelyhood
  yF ~ binomial(nF,pF);
  yM ~ binomial(nM,pM);
  
}

