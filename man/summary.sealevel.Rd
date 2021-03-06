\name{summary.sealevel}

\alias{summary.sealevel}
\alias{summary,sealevel,missing-method}
\alias{summary,sealevel-method}

\title{Summarize a sealevel object}

\description{Summarizes some of the data in a sealevel object.}

\usage{\S4method{summary}{sealevel}(object, \dots)}

\arguments{
  \item{object}{an object of class \code{"sealevel"}, usually, a result of a
    call to \code{\link{read.sealevel}}, \code{\link{read.oce}}, or
    \code{\link{as.sealevel}}.}
  \item{\dots}{further arguments passed to or from other methods.}
}

\details{Pertinent summary information is presented.}

\value{An object of class \code{"summary.sealevel"}, which contains
  pertinent information about the sealevel record and its processing.}

\seealso{The documentation for \code{\link{sealevel-class}} explains the
    structure of sealevel objects, and also outlines the other functions
    dealing with them.}

\examples{
library(oce)
data(sealevelHalifax)
summary(sealevelHalifax)
}

\author{Dan Kelley}

\keyword{misc}
