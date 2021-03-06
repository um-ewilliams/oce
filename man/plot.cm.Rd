\name{plot.cm}

\alias{plot.cm}
\alias{plot,cm,missing-method}
\alias{plot,cm-method}

\title{Plot cm (current meter) data}

\description{Plot \code{cm} (current meter) data}

\usage{\S4method{plot}{cm}(x,
     which=c(1, 2, 7, 9),
     type="l",
     adorn=NULL,
     drawTimeRange=getOption("oceDrawTimeRange"),
     drawZeroLine=FALSE,
     mgp=getOption("oceMgp"),
     mar=c(mgp[1]+1.5,mgp[1]+1.5,1.5,1.5),
     small=2000,
     main="",
     tformat,
     debug=getOption("oceDebug"),
     \dots)
}

\arguments{
    \item{x}{an \code{cm} object, e.g. as read by \code{\link{read.cm}}.}
    \item{which}{list of desired plot types.  These are graphed in
        panels running down from the top of the page.  See \dQuote{Details}
        for the meanings of various values of \code{which}.}
    \item{type}{type of plot, as for \code{\link{plot}}.}
    \item{adorn}{optional list of \code{\link{expression}}s to be performed
        immediately after drawing the panels. (See \code{\link{plot.adp}} for
        an example.)}
    \item{drawTimeRange}{boolean that applies to panels with time as the
        horizontal axis, indicating whether to draw the time range in 
        the top-left margin of the plot.}
    \item{drawZeroLine}{boolean that indicates whether to draw zero
        lines on velocities.}
    \item{mgp}{3-element numerical vector to use for \code{par(mgp)}, and
        also for \code{par(mar)}, computed from this.  The default is
        tighter than the R default, in order to use more space for the data
        and less for the axes.}
    \item{mar}{value to be used with \code{\link{par}("mar")}.}
    \item{small}{an integer indicating the size of data set to be
        considered "small", to be plotted with points or lines using the
        standard \code{\link{plot}} function.  Data sets with more than
        \code{small} points will be plotted with \code{\link{smoothScatter}}
        instead.}
    \item{main}{main title for plot, used just on the top panel, if there are
        several panels.}
    \item{tformat}{optional argument passed to \code{\link{oce.plot.ts}}, for
        plot types that call that function.  (See \code{\link{strptime}} for the
        format used.)}
    \item{debug}{a flag that turns on debugging.  Set to 1 to get a
        moderate amount of debugging information, or to 2 to get more.} 
    \item{\dots}{optional arguments passed to plotting functions.}
}

\details{Creates a multi-panel summary plot of data measured by a
    current meter.  The panels are controlled by the \code{which}
    argument, as follows.
    \itemize{ 
        \item \code{which=1} or \code{which="u"} for a time-series graph of
        eastward velocity, \code{u}, as a function of time.
        \item \code{which=2} or \code{which="v"} for a time-series graph of
        northward velocity, \code{u}, as a function of time.
        \item \code{which=3} or \code{"progressive vector"} for
        progressive-vector plot
        \item \code{which=4} or \code{"uv"} for a plot of \code{v} versus
        \code{u}.  (Dots are used for small datasets, and smoothScatter for
        large ones.)
        \item \code{which=5} or \code{"uv+ellipse"} as the \code{"uv"}
        case, but with an added indication of the tidal ellipse,
        calculated from the eigen vectors of the covariance matrix.
        \item \code{which=6} or \code{"uv+ellipse+arrow"} as the
        \code{"uv+ellipse"} case, but with an added arrow indicating the
        mean current.
        \item \code{which=7} or \code{"depth"} for depth
        \item \code{which=8} or \code{"salinity"} for salinity
        \item \code{which=9} or \code{"temperature"} for temperature
        \item \code{which=10} or \code{"heading"} for heading
        \item \code{which=11} or \code{"TS"} for a TS diagram
    }
}

\seealso{The documentation for \code{\link{cm-class}} explains the structure of
    CM objects, and also outlines the other functions dealing with them.}

\examples{
library(oce)
if (require(ocedata)) {
    data(cm)
    summary(cm)
    plot(cm)
}
}

\author{Dan Kelley}
\keyword{hplot}
