\name{read.topo}

\alias{read.topo}

\title{Read an topography file}

\description{Read a file that contains topographic data in the ETOPO2 dataset, 
  as provided by the NOAA website.}

\usage{read.topo(file, processingLog, \dots)}

\arguments{
  \item{file}{name of a file containing an ETOPO2 dataset.}
  \item{processingLog}{if provided, the action item to be stored in the
    log.  (Typically only provided for internal calls; the default that
    it provides is better for normal calls by a user.)}
  \item{\dots}{additional arguments, passed to called routines.}
}
\value{An object of type \code{\link[base]{class}} \code{"topo"},
  which is a list containing the following items.
  \item{data}{a data frame containing \code{lat},
    \code{lon}, and \code{z}}
  \item{metadata}{a list containing the source filename}
  \item{processingLog}{a processingLog, in the standard \code{oce} format.}
}

\examples{
\dontrun{
library(oce)
topoMaritimes <- read.topo("topoMaritimes.asc")
plot(topographyMaritimes)
}
}

\references{\url{http://www.ngdc.noaa.gov/mgg/gdas/gd_designagrid.html}}

\author{Dan Kelley}

\keyword{misc}
