# fastlogitME
Basic but Fast Marginal Effects for Logit Models in R
I wrote this function to work with large datasets in R. Estimating logit models and the respective marginal effects can in these cases take a long time and a lot of CPU. Therefore I make use of speed.glm to estimate the logit model and I use this function to calculate the marginal effects, as well as the confidence intervals and p-values of said marginal effects. In the help file of the function I included details on how to export these results with stargazer.
