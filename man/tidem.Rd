% vim:textwidth=100:expandtab:shiftwidth=2:softtabstop=2
\name{tidem}

\alias{tidem}
\title{Fit a tidal model to a timeseries}

\description{Fit a tidal model to a timeseries.}

\usage{tidem(x, t, constituents, latitude=NULL, rc=1, regress=lm,
      debug =getOption("oceDebug"))}

\arguments{

  \item{x}{Either a \code{sealevel} object (e.g. produced by \code{\link{read.sealevel}} or
    \code{\link{as.sealevel}}) or a list of numbers.  In the former case, time is part of the
    object, so \code{t} may not be given here.  In the latter case, \code{tidem} needs a way to
    determine time, so \code{t} must be given.}
      
  \item{t}{An indication of times, to be given only if \code{x} is numeric.  There are two styles:
    \code{t} may be a POSIXt vector of times at which the \code{x} observations were made, or
    \code{t} may be a single number indicating the number of seconds between those observations.
    (In the latter case, a sealevel object is created, starting at \code{as.POSIXct("2000-01-01
      00:00:00", tz="UTC")}.  The starting time is irrelevant to the fitted coefficients, but it
    \emph{does} matter if \code{\link{predict.tidem}} is to be used.)}
  
  \item{constituents}{an optional list of tidal constituents to which the fit is done (see
    \dQuote{Details}.)}  

  \item{latitude}{if provided, the latitude of the observations.  If not provided, \code{tidem} will
    try to infer this from \code{sl}.}

  \item{rc}{the value of the coefficient in the Rayleigh criterion.}

  \item{regress}{function to be used for regression, by default \code{\link{lm}}, but could be for
    example \code{rlm} from the \code{MASS} package.}

  \item{debug}{a flag that turns on debugging.  Set to 1 to get a moderate amount of debugging
    information, or to 2 to get more.} 
  
}

\details{The fit is done in terms of sine and cosine components at the indicated tidal frequencies,
  with the amplitude and phase being calculated from the resultant coefficients on the sine and
  cosine terms.
  
  The tidal constituents to be used in the analysis are specified as follows.

  \enumerate{

  \item{Case 1.}{If \code{constituents} is not provided, then the
  constituent list will be made up of the 69 constituents regarded by
  Foreman as standard.  These include astronomical frequencies and some
  shallow-water frequencies, and are as follows: \code{c("Z0", "SA",
  "SSA", "MSM", "MM", "MSF", "MF", "ALP1", "2Q1", "SIG1", "Q1", "RHO1",
  "O1", "TAU1", "BET1", "NO1", "CHI1", "PI1", "P1", "S1", "K1", "PSI1",
  "PHI1", "THE1", "J1", "SO1", "OO1", "UPS1", "OQ2", "EPS2", "2N2",
  "MU2", "N2", "NU2", "GAM2", "H1", "M2", "H2", "MKS2", "LDA2", "L2",
  "T2", "S2", "R2", "K2", "MSN2", "ETA2", "MO3", "M3", "SO3", "MK3",
  "SK3", "MN4", "M4", "SN4", "MS4", "MK4", "S4", "SK4", "2MK5", "2SK5",
  "2MN6", "M6", "2MS6", "2MK6", "2SM6", "MSK6", "3MK7", "M8")}.}

  \item{Case 2.}{If the first item in \code{constituents} is the string
  \code{"standard"}, then a provisional list is set up as in Case 1, and
  then the (optional) rest of the elements of \code{constituents} are
  examined, in order.  Each of these constituents is based on the name
  of a tidal constituent in the Foreman (1977) notation.  (To get the
  list, execute \code{data(tideData)} and then
  execute \code{cat(tideData$name)}.)  Each named constituent is
  added to the existing list, if it is not already there.  But, if the
  constituent is preceeded by a minus sign, then it is removed from the
  list (if it is already there).  Thus, for example,
  \code{constituents=c("standard", "-M2", "ST32")} would remove the M2
  constituent and add the ST32 constituent.}

  \item{Case 3.}{If the first item is not \code{"standard"}, then the
  list of constituents is processed as in Case 2, but without starting
  with the standard list. As an example, \code{constituents=c("K1",
  "M2")} would fit for just the K1 and M2 components. (It would be
  strange to use a minus sign to remove items from the list, but the
  function allows that.)}

  In each of the above cases, the list is reordered in frequency prior
  to the analysis, so that the results of \code{\link{summary.tidem}}
  will be in a familiar form.

  Once the constituent list is determined, \code{tidem} prunes the
  elements of the list by using the Rayleigh criterion, according to
  which two constituents of frequencies \eqn{f_1}{f1} and \eqn{f_2}{f2}
  cannot be resolved unless the time series spans a time interval of at
  least \eqn{rc/(f_1-f_2)}{rc/(f1-f2)}. The value \code{rc=1} yields
  nominal resolution.

  A list of constituent names is created by the following:
  \preformatted{
    data(tidedata)
    print(tidedata$const$name)
  }

  \strong{The text should include discussion of the (not yet performed)
  nodal correction treatement.}
} % enumerate
} % details

\section{Bugs}{
  
  \enumerate{
    \item{1.}{This function is not fully developed yet, and both the
      form of the call and the results of the calculation may change.}
    
    \item{2.}{Nodal correction is not done.}
    
    \item{3.}{The reported \code{p} value may make no sense at all, and it might be removed in a
      future version of this function. Perhaps a significance level should be presented, as in the
      software developed by both Foreman and Pawlowicz.}
    
  } % enumerate
  
} % note


\value{An object of \code{\link[base]{class}} \code{"tide"}, consisting of
  \item{const}{constituent number, e.g. 1 for \code{Z0}, 1 for \code{SA}, etc.}
  \item{model}{the regression model}
  \item{name}{a vector of constituent names, in non-subscript format, e.g. "\code{M2}".}
  \item{frequency}{a vector of constituent frequencies, in inverse hours.}
  \item{amplitude}{a vector of fitted constituent amplitudes, in metres.}
  \item{phase}{a vector of fitted constituent phase.  NOTE: The
    definition of phase is likely to change as this function evolves.
    For now, it is phase with respect to the first data sample.} 
  \item{p}{a vector containing a sort of p value for each constituent.
    This is calculated as the average of the p values for the sine() and
    cosine() portions used in fitting; whether it makes any sense is an
    open question.} 
}

\seealso{\code{\link{summary.tidem}} summarizes a "\code{tide}" object,
  \code{\link{plot.tidem}} plots one, and \code{\link{predict.tidem}}
  makes predictions from one.  As for the input, sealevel objects may be
  created with \code{\link{as.sealevel}} or \code{\link{read.sealevel}}.  See
  notes at \code{\link[ocedata]{sealevelTuktoyaktuk}}, which is test data set.
}

\examples{
library(oce)
# The demonstration time series from Foreman (1977),
# also used in T_TIDE (Pawlowicz, 2002).
data(sealevelTuktoyaktuk)
tide <- tidem(sealevelTuktoyaktuk)
summary(tide)

# AIC analysis
extractAIC(tide[["model"]])

# Fake data at M2
t <- seq(0, 10*86400, 3600)
eta <- sin(0.080511401 * t * 2 * pi / 3600)
sl <- as.sealevel(eta)
m <- tidem(sl)
summary(m)

}

\references{
  Foreman, M. G. G., 1977.
  Manual for tidal heights analysis and prediction.
  Pacific Marine Science Report 77-10,
  Institute of Ocean Sciences, Patricia Bay, Sidney, BC, 58pp.
  
  Foreman, M. G. G., Neufeld, E. T., 1991.
  Harmonic tidal analyses of long time series.
  International Hydrographic Review, 68 (1), 95-108.

  Leffler, K. E. and D. A. Jay, 2009.
  Enhancing tidal harmonic analysis: Robust (hybrid) solutions.
  Continental Shelf Research, 29(1):78-88.
  
  Pawlowicz, Rich, Bob Beardsley, and Steve Lentz, 2002.
  Classical tidal harmonic analysis including error estimates in MATLAB using \code{T_TIDE}.
  Computers and Geosciences, 28, 929-937.
}

\author{Dan Kelley}

\keyword{misc}

\concept{tide}
