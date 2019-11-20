
----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------

XSReg: Two-stage regressions with "correct" standard errors

----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------

This file was downloaded from www.julianthimme.de

Contact me: julian.thimme(at)hof.uni-frankfurt(dot)de


----------------------------------------------------------------------------------------------
 GENERAL INFORMATION
----------------------------------------------------------------------------------------------

XSReg performs a two-stage (time series + cross-sectional) regression a la Fama/MacBeth but 
provides standard errors that account for errors-in-variables, heteroskedasticity and 
autocorrelation in error terms. 

Technically, the standard errors are GMM standard errors. The GMM moment conditions correspond
to simple OLS regressions. Thus, the point estimates are equal to those from a Fama/MacBeth 
regression. 

The main function is called "XSReg". The functionality and syntax of the program are explained
below. It is a corrected and generalized version of a program provided in Kevin Sheppard's 
MATLAB course, see the script, Section 22.2. The script can be downloaded at 
https://www.kevinsheppard.com/MFE_MATLAB.

There are four additional programs which are necessary to run the program "XSReg":
 display_results   Prints results to screen and generates plot
 longvar           Estimates long-run covariance matrix
 kernelest         Computes Bartlett or Parzen weights
 optbandw          Newey and Wests's method of optimal bandwidth selection

The latter three programs are taken from Kostas Kyriakoulis' GMM package which can be 
downloaded at https://personalpages.manchester.ac.uk/staff/Alastair.Hall/GMMGUI.html



----------------------------------------------------------------------------------------------
 HOW TO RUN THE PROGRAM
----------------------------------------------------------------------------------------------

Unzip the file and save the folder on your hard disc. Start MATLAB and change the directory to 
the path where you saved the programs. 

----------------------------------------------------------------------------------------------
 THE FUNCTION XSReg.m
----------------------------------------------------------------------------------------------

SYNTAX: 
 [lambda, tlambda, R2adj, RMSE, alpha, talpha, beta, tbeta, GRS, pval, vcv] 
  = XSReg(returns, factors, constant, print, nw_center, nw_method, nw_lags)

INPUT
 returns       A matrix with test asset return time series in columns 
 factors       A matrix with factor time series in columns

OPTIONAL INPUT
 constant      0 <-- cross-sectional regression is performed without a constant 
               1 (default) <-- cross-sectional regression is performed with a constant
 print         0 <-- results are not printed to screen
               1 (default) <-- results are printed to screen
               2 <-- results are printed to screen and a plot is created
 nw_lags       The bandwidth used in the HACC estimates. Must be a
               non-negative integer (or zero, in the case of serially 
               uncorrelated moments). 
               If nw_lags=[] (default), the program will automatically 
               calculate the optimal bandwidth, using Newey and Wests's 
               method of bandwidth selection.              
 nw_center     0 <-- errors are not demeaned before covariance estimation
               1 (default) <-- errors are demeaned 
 nw_method     There are three methods available for calculating the
               covariance matrix. Set this input equal to:
               'HACC_B' <-- for HACC with Bartlett kernel
               'HACC_P' <-- for HACC with Parzen kernel
               'SerUnc' <-- for Serially uncorrelated errors

OUTPUT
 lambda        Point estimates of the market prices of risk
 tlambda       t-statistics of lambda
 R2adj         Cross-sectional adjusted R2
 RMSE          Root-mean-squared pricing error
 alpha         Intercepts from time series regressions
 talpha        t-statistics of alpha
 beta          Slope coefficients from time series regressions
 tbeta         t-statistics of beta
 GRS           Gibbons/Ross/Shanken statistic
 pval          p-value of the GRS statistic
 vcv           Covariance matrix of the parameter estimates
                     
----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------

