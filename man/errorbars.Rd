\name{errorbars}
\alias{errorbars}

\title{Draw error bars on an existing xy diagram}

\description{Draw error bars on an existing xy diagram}

\usage{errorbars(x, y, xe, ye, percent=FALSE, style=0, length=0.025, \dots)}

\arguments{
\item{x}{x coordinates of points on the existing plot.}
\item{y}{y coordinates of points on the existing plot.}
\item{xe}{error on x coordinates of points on the existing plot, either a
    single number or a vector of length identical to that of \code{y}.}
\item{ye}{as \code{xe} but for y coordinate.}
\item{percent}{boolean flag indicating whether \code{xe} and \code{ye}
    are in terms of percent of the corresponding \code{x} and \code{y} values.}
\item{style}{indication of the style of error bar.  Using \code{style=0} yields
    simple line segments (drawn with \code{\link{segments}}) and \code{style=1}
    yields line segments with short perpendicular endcaps.}
\item{length}{length of endcaps, for \code{style=1} only; it is passed to
    \code{\link{arrows}}, which is used to draw that style of error bars.}
\item{\dots}{graphical parameters passed to the code that produces the error
    bars, e.g. to \code{\link{segments}} for \code{style=0}.}
}

\details{Only \code{style=0} is permitted at the moment.}

\examples{
library(oce)
if (require(ocedata)) {
    data(ctd)
    S <- ctd[["salinity"]]
    T <- ctd[["temperature"]]
    plot(S, T)
    errorbars(S, T, 0.05, 0.5)
}
}

\author{Dan Kelley}

\keyword{hplot}
