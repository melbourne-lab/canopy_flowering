// Exponential curve with beta regression
// SN - May 26 2023

// Input data
data {
  // Number of data points
  int<lower=0> N;
  // Number of groups (in this model, sensors)
  int<lower=0> J;
  
  // Data vectors
  
  // sensor ID
  int<lower=1, upper=J> s[N];
  // path length (number of occupied voxels traversed)
  vector[N] x;
  // transmittance (sensor reading divided by concurrent reference sensor reading)
  vector[N] y;
  
}

// Parameters for the model to estimate (and return)
parameters {
  
  // Intercept for exponential decay link
  // real<lower=0, upper=1> alpha; // including this makes the model worse
  
  // decay rate for exponential decay link
  real mu_decay;
  // standard deviation of random effect
  real<lower=0> sigma_j;
  // sensor-level rate random effect 
  // (estimates one decay rate for each vector)
  real<lower=0> beta[J];
  
  // phi parameter
  real<lower=0> phi_beta;
}

// Model to be estimated
model {
  
  // expectation for each data point
  vector[N] g;

  // Draw intercept term from beta prior
  // alpha ~ beta(10, 1);

  // Estimating decay rates
  
  // (mu_decay + sigma_j^2) is mean of lognormal
  mu_decay ~ normal(-2, 1);
  sigma_j ~ exponential(5);
  
  // Draw sensor-level decay rates (log-transformed)
  beta ~ lognormal(mu_decay, sigma_j);
  
  // Draw the phi parameter for beta residuals
  phi_beta ~ lognormal(0, 1);
  
  // defining mean (expectation) of transmittance for each data point
  for (n in 1:N) {
    // Estimate expected transmittance for each data point
    g[n] = exp(-beta[s[n]] * x[n]);
    // Likelihood draw for residuals
    //    alpha: g * phi, beta: (1-g) * phi
    //    mean: g; variance: g * (1-g) / (phi + 1)
    y[n] ~ beta(g[n] * phi_beta, (1-g[n]) * phi_beta);
    
    // Print statements for when g[n] is zero
    // if (g[n] == 0) {
    //   print("")
    //   print(sigma_j)
    //   print(beta[s[n]])
    // }
  }
  
}

