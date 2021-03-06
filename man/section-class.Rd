\name{section-class}

\docType{class}

\alias{section-class}
\alias{[[,section-method}
\alias{[[<-,section-method}
\alias{show,section-method}

\title{Class to store hydrographic section data}

\description{Class to store hydrographic section data, with standard slots
    \code{metadata}, \code{data} and \code{processingLog}.}

\section{Methods}{
    The examples given below use \code{s} to represent the name of a section.

    \subsection{Extracting values}{A \code{\link{list}} of stations is
        retrieved by \code{s[["station"]]}.  Individual stations are retrieved
        by providing a station number as a second argument in the index, e.g.
        the first station is \code{s[["station", 1]]} (which is a
        \code{\link{ctd-class}} object).
        
        Aggregated values of the quantities measured at each level of the CTD
        profiles contained within the section may be accessed as e.g.
        \code{section[["salinity"]]}.  This works for any quantity whose name
        is present in the constituent profiles.   

        Since it is often useful to pair such quantities with locations,
        \code{section[["longitude"]]} and \code{section[["latitude"]]} return
        vectors with values repeated for each level in each CTD (see the
        \code{pairs()} call in the example section).  If just one latitude or
        longitude is desired per station, e.g. \code{section[["latitude",
            "byStation"]]} may be used.  Station-by-station values of dynamic
        height are provided by e.g. \code{section[["dynamic height"]]}.  The
        depths (actually pressures) of all data are obtained from e.g.
        \code{section[["depth"]]}, and the distances along the transect
        (measured from the first station) are obtained from e.g.
        \code{section[["distance"]]}.}
    
    \subsection{Assigning values}{(This feature has yet to be added.)}
    
    \subsection{Overview of contents}{The \code{show} method (e.g.
        \code{show(section)}) displays information about the object.}
}

\seealso{Sections can be read with \code{\link{read.section}} or created with
    \code{\link{read.section}} or created from CTD objects by using
    \code{\link{makeSection}} or by combining an existing section with a CTD
    object with the \code{+} operator.  
    
    Sections may be sorted with \code{\link{sectionSort}}, subsetted with
    \code{\link{subset.section}}, smoothed with \code{\link{sectionSmooth}},
    and gridded with \code{\link{sectionGrid}}.  Gridded sections may be
    plotted with \code{\link{plot.section}}.  
    
    Statistical summaries are provided by \code{\link{summary.section}}, while
    overviews are provided by \code{show.section}.  
    
    The sample dataset \code{\link{section}} contains data along WOCE line A03.

}

\examples{
library(oce)
if (require(ocedata)) {
    data(section)
    plot(section[['station', 1]])
    pairs(cbind(z=-section[["pressure"]],T=section[["temperature"]],S=section[["salinity"]]))
    ## T profiles for first few stations in section, at common scale
    par(mfrow=c(3,3))
    Tlim <- range(section[["temperature"]])
    ylim <- rev(range(section[["pressure"]]))
    for (stn in section[["station",1:9]])
        plotProfile(stn, xtype='temperature', ylim=ylim, Tlim=Tlim)
}
}

\author{Dan Kelley}

\keyword{classes}

\keyword{oce}

