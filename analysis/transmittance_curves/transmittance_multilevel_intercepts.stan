// Exponential curve fitting for light transmittance models
// with a multilevel component for rate and intercept

// Intercept is a work in progress... not sure if this will work

data {
  // Number of data points
  int<lower=0> N;
  // Number of groups
  //  (in this model, sensors)
  //  (for now - leave this out - no multi-level stuff)
  int<lower=0> J;
  
  // Data vectors
  // sensor 
  int<lower=1, upper=J> s[N];
  // path length (may be squared)
  vector[N] x;
  // mean transmittance
  vector[N] y;
  
  // Prior for decay random effect
  real sigma_g_scale;
  // Prior for intercept random effect
  // real sigma_b_scale;
}

// The parameters accepted by the model.
parameters {
  // decay rate for exponential function
  real k;
  // sensor-level random effect of decay rate
  real<lower=0> gamma[J];
  // standard deviation of decay random effect
  real<lower=0> sigma_g;

  // beta parameter of beta distribution
  real b;
  // sensor-level random effect of intercept
  real<lower=0, upper=1> beta[J];
  // rate of exponential random effect on b
  // real<lower=0> lambda_b;
  
  // standard deviation of likelihood
  real<lower=0> sigma_i;

}

// The model to be estimated.
model {
  
  // mean for each path length for each sensor
  vector[N] g;
  
  // intercept
  b ~ exponential(100);
  // lambda_b ~ student_t(4, 0, sigma_b_scale);
  
  beta ~ beta(10, b);
  
  // decay rate
  // k is mean of lognormal
  k ~ normal(-1, 1);
  sigma_g ~ student_t(4, 0, sigma_g_scale);
  
  gamma ~ lognormal(k, sigma_g);
  
  // defining mean (expectation) for each data point
  for (n in 1:N) {
    g[n] = beta[s[n]] * exp(-gamma[s[n]] * x[n]);
  }
  
  g ~ normal(y, sigma_i); // need a better distribution... normal is not good
}

