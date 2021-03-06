\name{pwelch}

\alias{pwelch}

\title{Welch periodogram}

\description{Compute periodogram using the Welch (1967) method}

\usage{pwelch(x, window, noverlap, nfft, fs, spectrumtype, esttype,
     plot=TRUE, debug=getOption("oceDebug"), \dots)}

\arguments{
  \item{x}{a vector or timeseries to be analyzed.  If a timeseries,
    then there is no need to specify \code{fs}.}
  \item{window}{window specification, either a single value giving the number
      of windows to use, or a vector of window coefficients.  If not specified,
      then 8 windows are used, each with a Hamming (raised half-cosine) window.}
  \item{noverlap}{number of points to overlap between windows.  If not
    specified, this will be set to half the window length.}
  \item{nfft}{length of FFT.  This cannot be given if \code{window} is
    given, and the latter is a single integer.}
  \item{fs}{frequency of time-series.  If \code{x} is a time-series,
    and if \code{fs} is supplied, then time-series is altered to have
    frequency \code{fs}.}
  \item{spectrumtype}{not used (yet)}
  \item{esttype}{not used (yet)}
  \item{plot}{logical, set to \code{TRUE} to plot the spectrum.}
  \item{debug}{a flag that turns on debugging.  Set to 1 to get a
    moderate amount of debugging information, or to 2 to get more.}
  \item{\dots}{optional extra arguments to be passed to
      \code{\link{spectrum}}. Unless specified in this list,
    \code{\link{spectrum}} is called with \code{plot=FALSE} to prevent
    plotting the separate spectra, and with \code{taper=0}, 
    which is not needed with the default Hanning window.  However, the
    other defaults of \code{\link{spectrum}} are used,
    e.g. \code{detrend=TRUE}.}
}
 
\value{List mimicking the return value from \code{\link{spectrum}}, containing
    frequency \code{freq}, spectral power \code{spec}, degrees of freedom
    \code{df}, bandwidth \code{bandwidth}, etc.}

\section{Bugs}{Both bandwidth and degrees of freedom are just copied from the
    values for one of the chunk spectra, and are thus incorrect.  That means
    the cross indicated on the graph is also incorrect.}

\details{The Welch (1967) method is used.  First, \code{x} is broken up into
    chunks, overlapping as specified by \code{noverlap}.  These chunks are then
    detrended with \code{\link{detrend}}, multiplied by the window, and then
    passed to \code{\link{spectrum}}.  The resulting spectra are then averaged,
    with the results being stored in \code{spec} of the return value.  Other
    entries of the return value mimic those returned by
    \code{\link{spectrum}}.}

\examples{
library(oce)
Fs <- 1000
t <- seq(0, 0.296, 1/Fs)
x <- cos(2 * pi * t * 200) + rnorm(n=length(t))
xts <- ts(x, frequency=Fs)
s <- spectrum(xts, spans=c(3,2), main="random + 200 Hz", log='no')
w <- pwelch(xts, plot=FALSE)
lines(w$freq, w$spec, col="red")
w2 <- pwelch(xts, nfft=75, plot=FALSE)
lines(w2$freq, w2$spec, col='green')
abline(v=200, col="blue", lty="dotted")
cat("Checking spectral levels with Parseval's theorem:\n")
cat("var(x)                              = ", var(x), "\n")
cat("2 * sum(s$spec) * diff(s$freq[1:2]) = ", 2 * sum(s$spec) * diff(s$freq[1:2]), "\n")
cat("sum(w$spec) * diff(s$freq[1:2])     = ", sum(w$spec) * diff(w$freq[1:2]), "\n")
cat("sum(w2$spec) * diff(s$freq[1:2])    = ", sum(w2$spec) * diff(w2$freq[1:2]), "\n")
## co2
par(mar=c(3,3,2,1), mgp=c(2,0.7,0))
s <- spectrum(co2, plot=FALSE)
plot(log10(s$freq), s$spec * s$freq,
     xlab=expression(log[10]*Frequency), ylab="Power*Frequency", type='l')
title("Variance-preserving spectrum")
pw <- pwelch(co2, nfft=256, plot=FALSE)
lines(log10(pw$freq), pw$spec * pw$freq, col='red')
}

\references{
Welch, P. D., 1967.
The Use of Fast Fourier Transform for the Estimation of Power
Spectra: A Method Based on Time Averaging Over Short, Modified
Periodograms.
\emph{IEEE Transactions on Audio Electroacoustics},
AU-15,
70--73.
}

\author{Dan Kelley}

\keyword{misc}
