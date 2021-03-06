\name{as.topo}
\alias{as.topo}
\title{Coerce data into topo dataset}
\description{
  Coerces a dataset  into a topo (topographic) dataset.
}
\usage{as.topo(longitude, latitude, z, filename="", processingLog)}

\arguments{
  \item{longitude}{a vector of longitudes}
  \item{latitude}{a vector of latitudes}
  \item{z}{a matrix of heights (positive over land)}
  \item{filename}{name of data (used when called by \code{\link{read.topo}})}
  \item{processingLog}{a log action (used when called by \code{\link{read.topo}})
}}

\details{Mainly used by \code{\link{read.topo}}.}

\value{An object of \code{\link[base]{class}} \code{"topo"}.}

\seealso{
  \code{\link{read.topo}}, which calls this.
}
\author{Dan Kelley}
\keyword{misc}
