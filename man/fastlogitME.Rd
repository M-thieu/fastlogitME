\name{fastlogitME}
\alias{fastlogitME}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Basic Marginal Effects for Logit Models
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
Calculates marginal effects based on logistic model objects such as "glm" or "speed.glm" at the average (default) or at given values indicated by \emph{at}. It also returns confidence intervals for said marginal effects and the p-values, which can easily be inputed in stargazer. The function only returns the essentials and is therefore much faster but not as detailed as other functions available to calculate marginal effects. As a result, it is highly suitable for large datasets.
}
\usage{
fastlogitME(model, at = NULL, vars = NULL, conf.band = .95)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{model}{
  a model object of the type "glm" or "speed.glm" where the family argument is specified to be binomial('logit')
}
\item{at}{
A list containing names of variables and specific values at which to calculate the marginal effects. The default is to calculate these at the mean of each continuous variable and for the reference category of dummy variables.
}
\item{vars}{
A character string or vector of character strings indicating the names of the variables for which marginal effects should be calculated. The default is all variables in the model object.
}
\item{conf.band}{
The bandwidth of the confidence interval has to be between 0 and 1. The default is .95, which corresponds to a 95\% confidence interval
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
This function is a fast but basic alternative to other packages destinated to calculating marginal effects for logit models. It is particularly helpful when working with large datasets, where other options may take too much time and/or CPU for some uses. It is also compatible with speed.glm, which also achieves time gains compared to glm.

The function calculates confidence intervals rather than standard errors because there is not a single standard error in terms of probabilities in a logit model. The standard error is given in log odds and therefore its size is different when converting to probabilities depending on how close to 0\% or 100\% it gets. As a result, a standard error in terms of probabilities, commonly derived from bootstrapping or the delta method, may exceed the range of 0\% to 100\% when estimating the probability of \dQuote{succes} at certain values in the dataset.

The results can easily be exported using stargazer. First one needs to use rbind to add a row of zeros as first row to the data.frame resulting from fastlogitME, this replaces the intercept stargazer is expecting to find.Use the logit model stated at the model argument of the function as input for stargazer. Replace the coefficients of this model by those in the column ME using the coef argument of stargazer. Set ci = TRUE to display confidence intervals instead of standard errors. Specify these confidence intervals using the columns Conflower and Confupper and the ci.custom argument of stargazer. Specify omit = "Constant" so the intercept is not reported.
3.
}
\value{
A data.frame containg the name of the variable, the marginal effect, the upper bound of the confidence interval, the lower bound of the confidence interval, and the p-value.
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
%%  ~~who you are~~
Mathieu Steijn \email{m.p.a.steijn@uu.nl}
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
# simulate some data
set.seed(12345)
n = 1000
x = rnorm(n)
z = sample(0:1, n, replace = TRUE)
cat = as.factor(sample(c("cat1", "cat2", "cat3"), n, replace = TRUE))
# binary outcome
y = ifelse(pnorm(1 + 0.5*x - 0.5*z + rnorm(n))>0.5, 1, 0)
data = data.frame(y,x,z,cat)
a<-glm(y ~ x + z + cat, data = data, family = binomial('logit'))
fastlogitME(a)
fastlogitME(a, at = list("x" = 1.2, "z" = 1, "catcat2" = 1), vars = c("x"), conf.band = .99)


}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ models }% use one of  RShowDoc("KEYWORDS")
\keyword{ htest }% __ONLY ONE__ keyword per line
