\name{undriftTime}

\alias{undriftTime}

\title{Correct for drift in instrument clock}

\description{Correct for drift in instrument clock}

\usage{undriftTime(x, slowEnd=0, tname="time")}

\arguments{
  \item{x}{an object of \code{\link[base]{class}} "\code{oce}".}
  \item{slowEnd}{number of seconds to add to final instrument time, to
    get the correct time of the final sample.  This will be a positive
    number, for a "slow" instrument clock.}
  \item{tname}{name of time column.}
}

\details{It is assumed that the instrument clock matches the real time at the
    start of the sampling, and that the clock drifts linearly (i.e. is
    uniformly fast or slow) over the sampling interval.  Linear interpolation
    is used to infer the values of all variables in the \code{data} slot.  The
    data length is altered in this process, e.g. a slow instrument clock
    (positive \code{slowEnd}) takes too few samples in a given time interval,
    so \code{undriftTime} will increase the number of data.}

\value{An object of the same class as \code{x}, with the \code{data} slot
    adjusted appropriately.}

\examples{
\dontrun{
library(oce)
rbr011855 <- read.oce(
 "/data/archive/sleiwex/2008/moorings/m08/pt/rbr_011855/raw/pt_rbr_011855.dat")
d <- subset(rbr011855, time < as.POSIXct("2008-06-25 10:05:00"))
x <- undriftTime(d, 1)	  # clock lost 1 second over whole experiment
summary(d)
summary(x)
}
}

\author{Dan Kelley}

\keyword{misc}
