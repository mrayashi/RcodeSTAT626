data {
  int<lower=0> N1;
  int<lower=0> N2;
  int<lower=0, upper=N1> y1;
  int<lower=0, upper=N2> y2;
}


parameters {
  real<lower=0, upper=1> p1;
  real<lower=0, upper=1> p2;
}

 transformed parameters {
  real logit_p1 = log(p1 / (1 - p1));
  real logit_p2 = log(p2 / (1 - p2));
  real log_or = logit_p2 - logit_p1 ;
 }

model {
  y1 ~ binomial(N1,p1);
  y2 ~ binomial(N2,p2);
  p1 ~ beta(1,1);
  p2 ~ beta(1,1);
}

