// Exponential curve fitting for light transmittance models
// with a multimodel component

// The input data is a vector 'y' of length 'N'.
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
  
  // Prior
  real sigma_j_scale;
}

// The parameters accepted by the model. Our model
// accepts two parameters 'mu' and 'sigma'.
parameters {
  // decay rate for exponential function
  real k;
  // standard deviation of likelihood
  real<lower=0> sigma_i;
  // sensor-level rate random effect
  real<lower=0> gamma[J];
  // standard deviation of random effect
  real<lower=0> sigma_j;
}

// The model to be estimated. We model the output
// 'y' to be normally distributed with mean 'mu'
// and standard deviation 'sigma'.
model {
  
  // mean for each path length for each sensor
  vector[N] g;
  
  // k is mean of lognormal
  k ~ normal(-1, 1);
  sigma_j ~ student_t(4, 0, sigma_j_scale);
  
  gamma ~ lognormal(k, sigma_j);
  
  // defining mean (expectation) for each data point
  for (n in 1:N) {
    g[n] = exp(-gamma[s[n]] * x[n]);
  }
  
  g ~ normal(y, sigma_i); // need a better distribution
}

