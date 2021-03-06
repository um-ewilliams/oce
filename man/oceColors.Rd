\name{oceColors}

\alias{oceColorsJet}
\alias{oceColorsGebco}
\alias{oceColorsTwo}
\alias{oceColorsPalette}
\alias{oceColors9A}
\alias{oceColors9B}

\title{Create a palette of colours}

\description{Create a palette of colours}

\usage{
oceColorsPalette(n, which=1)

oceColorsGebco(n=9, region=c("water", "land", "both"),
	type=c("fill","line"))

oceColorsJet(n)

oceColors9A(n)

oceColors9B(n)

oceColorsTwo(n, low=2/3, high=0, smax=1, alpha = 1)

}

\arguments{
\item{n}{the number of colors (\eqn{\ge 1}{>=1}) to be in the palette.}
\item{which}{an identifier for the palette  (see \dQuote{Details}).}
\item{region}{the region characteristic, for \code{oceColorsGebco}.}
\item{type}{the type of item drawn, for \code{oceColorsGebco}.}
\item{low}{the hue, in [0,1], for the low end of a \code{oceColorsTwo}
  scale.}
\item{high}{the hue, in [0,1], for the high end of a \code{oceColorsTwo}
  scale.}
\item{smax}{the maximum saturation, in [0,1], for the colors of \code{oceColorsTwo}.}
\item{alpha}{the alpha value, in [0,1], for the colors of \code{oceColorsTwo}.}
}

\details{

  \code{oceColorsPalette} provides a variety of pre-defined palettes.
  \code{which}=1 yields the ColorBrewer diverging red/blue scheme while
  \code{which}=2 yields the ColorBrewer diverging RYB scheme.  (Each is
  interpolated from the 11-class schemes provided on this site.)

  A family of nine-color schemes is as follows: \code{which="jet"} (or
  \code{which="9A"} or \code{which=9.01} for the Jet scheme; \code{which="9B"}
  or \code{which=9.02} for a scheme similar to Jet but omitting the green, and
  somewhat desaturating the yellow and cyane.

  \code{oceColorsGebco} provides palettes that mimic the GEBCO altas colours,
  with shades of blue for water and of brown for land.  The blue values go from
  dark to light, and the brown ones from light to dark; in this way,
  topographic images have light values near sea-level, and get darker in either
  deeper water or higher terrain.

  \code{oceColorsJet} provides a palette similar to the Matlab
  \dQuote{jet} palette.

  \code{oceColorsTwo} provides a two-tone palette that fades to white
  at central values.
}

\examples{
library(oce)
opar <- par(no.readonly = TRUE)
x <- array(1:1000, dim=c(1,1000))
par(mfrow=c(1,4))
image(x, col=oceColorsTwo(200), main="oceColorsTwo")
image(x, col=oceColorsJet(200), main="oceColorsJet")
image(x, col=oceColorsGebco(200), main="oceColorsGebco")
image(x, col=oceColorsPalette(200), main="oceColorsPalette")
par(opar)

# real-world example, with acoustic-doppler profiler data
if (require(ocedata)) {
    data(adp)
    par(mfrow=c(3,1))
    plot(adp, which='u1')
    plot(adp, which='u1', col=oceColorsJet)
    plot(adp, which='u1', col=oceColors9B)
}
}

\references{
Color Brewer.
\url{http://colorbrewer2.org/}

Light, A., and P. J. Bartlein, 2004.
The End of the Rainbow? Color Schemes for Improved Data Graphics.
\emph{Eos Trans. AGU}, 85(40), doi:10.1029/2004EO400002.

Martin Jakobsson, Ron Macnab, and Members of the Editorial Board, IBCAO.
Selective comparisons of GEBCO (1979) and IBCAO (2000) maps.
\url{http://www.ngdc.noaa.gov/mgg/bathymetry/arctic/ibcao_gebco_comp.html}

Stephenson, David B., 2005.
Comment on ``Color schemes for improved data graphics,''
by A. Light and P. J. Bartlein.
\emph{Eos Trans. AGU}, 86(20).
(See also \url{http://geography.uoregon.edu/datagraphics/color_scales.htm})


}

\author{Dan Kelley}

\keyword{color}
