\name{swSTrho}

\alias{swSTrho}

\title{Seawater salinity from temperature and density}

\description{Compute \emph{in-situ} salinity, given temperature,
  density, and pressure.}

\usage{swSTrho(temperature, density, pressure, eos=getOption("eos", default="unesco"))}

\arguments{
  \item{temperature}{\emph{in-situ} temperature [\eqn{^\circ}{deg}C]}
  \item{density}{\emph{in-situ} density or sigma value [\eqn{kg/m^3}{kg/m^3}]}
  \item{pressure}{\emph{in-situ} pressure [dbar]}
  \item{eos}{either \code{"unesco"} or \code{"teos"}.  If the latter, then the
      computer must have the TEOS library installed; see \code{\link{teos}}.}
}

\details{Finds the salinity that yields the given density, with the
  given temperature and pressure.  The method is a bisection search with
  a salinity tolerance of 0.001.  The isopycnal lines on
  temperature-salinity diagrams (\code{\link{plotTS}}) are computed
  with this function.}

\value{\emph{In-situ} salinity [PSU].}

\seealso{\code{\link{swTSrho}}}

\examples{
S <- swSTrho(10, 22, 0) # 28.651
}

\references{Fofonoff, P. and R. C. Millard Jr, 1983. Algorithms for
 computation of fundamental properties of seawater. \emph{Unesco
 Technical Papers in Marine Science}, \bold{44}, 53 pp

 Gill, A.E., 1982. \emph{Atmosphere-ocean Dynamics}, Academic Press, New
 York, 662 pp. 
}

\author{Dan Kelley}

\keyword{misc}
