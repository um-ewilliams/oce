## vim:textwidth=128:expandtab:shiftwidth=4:softtabstop=4
extract <- function(x, names)
{
    if (!inherits(x, "oce"))
        stop("method is only for oce objects")
    if (missing(x))
        stop("must supply 'x'")
    if (missing(names))
        stop("must supply 'names'")
    rval <- list()
    if (inherits(x, "section")) {
        for (name in names) {
            print(names(x@metadata))
            stationDataNames <- names(x@data$station[[1]]@data)
            print(stationDataNames)
            if (name %in% names(x)) {
                rval[[name]] <- x[[name]]
            } else if (name %in% names(x@metadata)) {
                if (name %in% c("longitude", "latitude", "stationId", "date")) {
                    item <- NULL
                    for (i in seq_along(x@data$station)) {
                        stn <- x@data$station[[i]]
                        item <- c(item, rep(x@metadata[[name]][[i]], length(x@data$station[[i]]@data$salinity)))
                    }
                    rval[[name]] = item
                } else {
                    rval[[name]] = x@metadata[[name]]
                }
            } else if (name %in% stationDataNames) {
                ##cat("in station data, for name=", name, "\n")
                item <- NULL
                for (i in 1:length(x@data$station)) {
                    ##cat("in station", i, "\n")
                    stn <- x@data$station[[i]]
                    item <- c(item, x@data$station[[i]]@data[[name]])
                }
                rval[[name]] <- item
            } else {
                stop("'", name, "' not in object's metadata or data$station[[1]]@data")
            }
        }
    } else if (inherits(x, "adp")) {
        for (name in names) {
            if (name %in% names(x)) {
                rval[[name]] <- x[[name]]
            } else if (name %in% names(x@metadata)) {
                rval[[name]] <-  x@metadata[[name]]
            } else if (name %in% names(x@data)) {
                rval[[name]] <- x@data[[name]]
            } else {
                stop("'", name, "' not in object")
            }
        }
    } else if (inherits(x, "adv")) {
        for (name in names) {
            if (name %in% names(x)) {
                rval[[name]] <- x[[name]]
            } else if (name %in% names(x@metadata)) {
                rval[[name]] <-  x@metadata[[name]]
            } else if (name %in% names(x@data)) {
                rval[[name]] <- x@data[[name]]
            } else {
                stop("'", name, "' not in object")
            }
        }
    } else {
        for (name in names) {
            if (name %in% names(x)) {
                rval[[name]] <- x[[name]]
            } else if (name %in% names(x@metadata)) {
                rval[[name]] = x@metadata[[name]]
            } else if (name %in% names(x@data)) {
                rval[[name]] = x@data[[name]]
            } else {
                stop("'", name, "' not in object")
            }
        }
    }
    rval
}

header <- function(x)
{
    if (!inherits(x, "oce"))
        stop("method is only for oce objects")
    return(x@metadata$header)
}

heading <- function(x, time)
{
    if (missing(x)) stop("must supply 'x'")
    if (!missing(time) && inherits(time, "oce")) {
        if ("timeSlow" %in% names(time@data)) {
            time <- time@data$timeSlow
        } else if ("time" %in% names(time@data)) {
            time <- time@data$time
        } else {
            stop("cannot determine time to which to interpolate")
        }
    }
    if (inherits(x, "adp")) {
        if (missing(time)) {
            return(x@data$heading)
        } else {
            return(approx(x@data$time, x@data$heading, time)$y)
        }
    } else if (inherits(x, "adv")) {
        if (missing(time)) {
            return(x@data$heading)
        } else {
            if ("timeSlow" %in% names(x@data)) {
                return(approx(x@data$timeSlow, x@data$headingSlow, time)$y)
            } else {
                return(approx(x@data$time, x@data$heading, time)$y)
            }
        }
    } else {
        stop("only works for 'adv' and 'adp' objects")
    }
}

"heading<-" <- function(x, value)
{
    if ("headingSlow" %in% names(x@data)) {
        x@data$headingSlow <- value
    } else if ("heading" %in% names(x@data)) {
        x@data$heading <- value
    } else {
        stop("object has no item named 'data$heading' or 'data$headingSlow'")
    }
    x
}

"pitch<-" <- function(x, value)
{
    if ("pitchSlow" %in% names(x@data)) {
        x@data$pitchSlow <- value
    } else if ("pitch" %in% names(x@data)) {
        x@data$pitch <- value
    } else {
        stop("object has no item named 'data$pitch' or 'data$pitchSlow'")
    }
    x
}

latitude <- function(x, time, byDepth=TRUE)
{
    if (inherits(x, "section")) {
        if (byDepth) {
            nstation <- length(x@data$station)
            rval <- NULL
            for (i in 1:nstation) {
                rval <- c(rval, rep(x@metadata$latitude[i], length.out=length(salinity(x@data$station[[i]]))))
            }
        } else {
            rval <- x@metadata$latitude
        }
    } else {
        if ("latitude" %in% names(x@metadata)) 
            rval <- x@metadata$latitude
        else if ("latitude" %in% names(x@data))
            rval <- x@data$latitude
        else
            stop("no 'latitude' in names(x@data) or names(x@metadata)")
    }
    rval 
}

longitude <- function(x, time, byDepth=TRUE)
{
    if (inherits(x, "section")) {
        if (byDepth) {
            nstation <- length(x@data$station)
            rval <- NULL
            for (i in 1:nstation) {
                rval <- c(rval, rep(x@metadata$longitude[i], length.out=length(salinity(x@data$station[[i]]))))
            }
        } else {
            rval <- x@metadata$longitude
        }
    } else {
        if ("longitude" %in% names(x@metadata)) 
            rval <- x@metadata$longitude
        else if ("longitude" %in% names(x@data))
            rval <- x@data$longitude
        else
            stop("no 'longitude' in names(x@data) or names(x@metadata)")
    }
    rval 
}

"latitude<-" <- function(x, value)
{
    if ("latitude" %in% names(x@metadata)) {
        x@metadata$latitude <- value[1]
    } else if ("latitude" %in% names(x@data)) {
        x@data$latitude <- value
    } else {
        stop("no item 'data$latitude$ or 'metadata$latitude' in object")
    }
    x
}

"longitude<-" <- function(x, value)
{
    if ("longitude" %in% names(x@metadata)) {
        x@metadata$longitude <- value[1]
    } else if ("longitude" %in% names(x@data)) {
        x@data$longitude <- value
    } else {
        stop("no item 'data$longitude$ or 'metadata$longitude' in object")
    }
    x
}

"pressure<-" <- function(x, value)
{
    if (!("pressure" %in% names(x@data)))
        stop("no item 'data$pressure' in object")
    x@data$pressure <- value
    x
}

"salinity<-" <- function(x, value)
{
    if (!("salinity" %in% names(x@data)))
        stop("no item 'data$salinity' in object")
    x@data$salinity <- value
    x
}

"temperature<-" <- function(x, value)
{
    if (!("temperature" %in% names(x@data)))
        stop("no item 'data$temperature' in object")
    x@data$temperature <- value
    x
}

pitch <- function(x, time)
{
    if (missing(x)) stop("must supply 'x'")
    if (!missing(time) && inherits(time, "oce")) {
        if ("timeSlow" %in% names(time@data)) {
            time <- time@data$timeSlow
        } else if ("time" %in% names(time@data)) {
            time <- time@data$time
        } else {
            stop("cannot determine time to which to interpolate")
        }
    }
    if (inherits(x, "adp")) {
        if (missing(time)) {
            return(x@data$pitch)
        } else {
            return(approx(x@data$time, x@data$pitch, time)$y)
        }
    } else if (inherits(x, "adv")) {
        if (missing(time)) {
            return(x@data$pitch)
        } else {
            if ("timeSlow" %in% names(x@data)) {
                return(approx(x@data$timeSlow, x@data$pitchSlow, time)$y)
            } else {
                return(approx(x@data$time, x@data$pitch, time)$y)
            }
        }
    } else {
        stop("only works for 'adv' and 'adp' objects")
    }
}

roll <- function(x, time)
{
    if (missing(x)) stop("must supply 'x'")
    if (!missing(time) && inherits(time, "oce")) {
        if ("timeSlow" %in% names(time@data)) {
            time <- time@data$timeSlow
        } else if ("time" %in% names(time@data)) {
            time <- time@data$time
        } else {
            stop("cannot determine time to which to interpolate")
        }
    }
    if (inherits(x, "adp")) {
        if (missing(time)) {
            return(x@data$roll)
        } else {
            return(approx(x@data$time, x@data$roll, time)$y)
        }
    } else if (inherits(x, "adv")) {
        if (missing(time)) {
            return(x@data$roll)
        } else {
            if ("timeSlow" %in% names(x@data)) {
                return(approx(x@data$timeSlow, x@data$rollSlow, time)$y)
            } else {
                return(approx(x@data$time, x@data$roll, time)$y)
            }
        }
    } else {
        stop("only works for 'adv' and 'adp' objects")
    }
}

"roll<-" <- function(x, value)
{
    if ("rollSlow" %in% names(x@data)) {
        x@data$rollSlow <- value
    } else if ("roll" %in% names(x@data)) {
        x@data$roll <- value
    } else {
        stop("object has no item named 'data$roll' or 'data$rollSlow'")
    }
    x
}

time.oce <- function(x, ...)
{
    which <- if ("which" %in% names(list(...))) list(...)$which else 1
    if (inherits(x, "adp")) {
        res <- x@data$time
    } else if (inherits(x, "adv")) {
        if (which == 1) {
            res <- x@data$time
        } else if (which == 2) {
            names <- names(x@data)
            if ("timeSlow" %in% names)
                res <- x@data$timeSlow
            else
                res <- x@data$time
        } else {
            stop("unknown 'which'; must be 1 for ADP velocity timescale, or 2 for ADP heading timescale")
        }
    } else {
        if ("time" %in% names(x@data))
            res <- x@data$time
        else
            stop("cannot determine times for this Oce object")
    }
    res
}

hydrographyLocal <- function(x, time, item) # FIXME consider broadening as replacement for extract()
{
    if (inherits(x, "section")) {
        if (item == "latitude") {
            rval <- NULL
            for (i in 1:length(x@data$station))
                rval <- c(rval, rep(x@metadata$latitude[i], length(x@data$station[[i]]@data$salinity)))
        } else if (item == "longitude") {
            rval <- NULL
            for (i in 1:length(x@data$station))
                rval <- c(rval, rep(x@metadata$longitude[i], length(x@data$station[[i]]@data$salinity)))
        } else {
            if (!(item %in% names(x@data$station[[1]]@data)))
                stop("the station data do not contain an item named \"", item, "\"")
            rval <- NULL
            for (station in seq_along(x@data$station)) {
                rval <- c(rval, x@data$station[[station]]@data[[item]])
            }
        }
    } else if (inherits(x, "adv")) {
        index <- agrep(item, names(x@data)) # use agrep to get e.g. temperatureSlow if given 'temperature'
        if (length(index))
            rval <- x@data[[index]]
        else
            stop("cannot find item named '", item, "' in object's data")
    } else if (inherits(x, "ctd")) {
        if (item == "latitude") {
            rval <- rep(x@metadata$latitude, length(x@data$salinity))
        } else if (item == "longitude") {
            rval <- rep(x@metadata$longitude, length(x@data$salinity))
        } else if (item == "time") {
            rval <- rep(x@metadata$startTime, length(x@data$salinity))
        } else {
            if (!(item %in% names(x@data)))
                stop("'x' does not contain data named \"", item, "\"")
            if (missing(time)) {
                rval <- x@data[[item]]
            } else {
                if (inherits(time, "oce")) {
                    time <- time@data$time # FIXME: if broadening, consider timeSlow also ... FIXME: what if S4
                } else if (!inherits(as.POSIXct("2008-01-01"), "POSIXt")) {
                    stop("'time' is neither a POSIXt time, nor an oce object containing data$time")
                }
                rval <- approx(time@data$time, x@data[[item]], time)$y # FIXME: if broadening, consider timeSlow also
            }
        }
    } else {
        if (!(item %in% names(x@data)))
            stop("'x' does not contain data named \"", item, "\"")
        if (missing(time)) {
            rval <- x@data[[item]]
        } else {
            if (inherits(time, "oce")) {
                time <- time@data$time # FIXME: if broadening, consider timeSlow also
            } else if (!inherits(as.POSIXct("2008-01-01"), "POSIXt")) {
                stop("'time' is neither a POSIXt time, nor an oce object containing data$time")
            }
            rval <- approx(time@data$time, x@data[[item]], time)$y # FIXME: if broadening, consider timeSlow also
        }
    }
    rval
}

distance <- function(x, time)
{
    if (inherits(x, "adp")) {
        x@data$distance
    } else {
        stop("x must be an object of class \"adp\"")
    }
}

elevation <- function(x, time) hydrographyLocal(x, time, "elevation")

pressure <- function(x, time) hydrographyLocal(x, time, "pressure")

salinity <- function(x, time) hydrographyLocal(x, time, "salinity")

spice <- function(x, time)
{
    S <- salinity(x, time)
    T <- temperature(x, time)
    p <- pressure(x, time)
    swSpice(S, T, p)
}

temperature <- function(x, time) hydrographyLocal(x, time, "temperature")
nitrate <- function(x, time) hydrographyLocal(x, time, "nitrate")
"nitrate<-" <- function(x, value) { x@data$nitrate <- value }
nitrite <- function(x, time) hydrographyLocal(x, time, "nitrite")
"nitrite<-" <- function(x, value) { x@data$nitrite <- value }
oxygen <- function(x, time) hydrographyLocal(x, time, "oxygen")
"oxygen<-" <- function(x, value) { x@data$oxygen <- value }
phosphate <- function(x, time) hydrographyLocal(x, time, "phosphate")
"phosphate<-" <- function(x, value) { x@data$phosphate <- value }
silicate <- function(x, time) hydrographyLocal(x, time, "silicate")
"silicate<-" <- function(x, value) { x@data$silicate <- value }

sigmaTheta <- function(x, time) hydrographyLocal(x, time, "sigmaTheta")

"sigmaTheta<-" <- function(x, value)
{
    x@data$sigmaTheta <- value
    x
}

tritium <- function(x, time)
    hydrographyLocal(x, time, "tritium")

time <- function(x)
{
    if (!("time" %in% names(x@data)))
        stop("no 'time' in names(x@data)")
    x@data$time
}

velocity <- function(x)
{
    if (!inherits(x, "oce"))
        stop("'x' must be an oce object")
    if (!("v" %in% names(x@data)))
        stop("'x' does not contain 'data$v'")
    x@data$v
}

"velocity<-" <- function(x, value)
{
    if (!("v" %in% names(x@data)))
        stop("no 'v' in names(x@data)")
    x@data$v <- value
    x
}
