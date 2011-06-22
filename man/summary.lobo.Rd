\name{summary.lobo}

\alias{summary.lobo}

\alias{print.summary.lobo}

\title{Summarize a lobo data object}

\description{Summarizes some of the data in a lobo object.}

\usage{
\method{summary}{lobo}(object, \dots)

\method{print}{summary.lobo}(x, digits=max(6, getOption("digits")-1), \dots)
}

\arguments{
  \item{object}{an object of class \code{"lobo"}, usually, a result of a
    call to \code{\link{read.lobo}} or \code{\link{read.oce}}.}
  \item{x}{an object of class \code{"summary.lobo"}, usually, a result of a
    call to \code{summary.lobo}.}
  \item{digits}{the number of significant digits to use when printing.}
  \item{\dots}{further arguments passed to or from other methods.}
}

\details{Pertinent summary information is presented, including the
  sampling interval, data ranges, etc.}

\value{An object of class \code{"summary.lobo"}, which contains
  pertinent information about the Lobo record and its processing.}

\seealso{The \code{lobo} object may be read with \code{\link{read.lobo}}
  (which should be consulted for details on the object structure) and
  plotted with \code{\link{plot.lobo}}.}

\examples{
library(oce)
data(lobo)
summary(lobo)
}

\references{
\url{http://lobo.satlantic.com}
\url{http://www.mbari.org/lobo/}
}

\author{Dan Kelley}

\keyword{misc}