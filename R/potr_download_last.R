potr_download_last <- function(opendata, destfile, filename, ...) {
  if (missing(opendata))
    stop("Valid input to 'opendata' and 'reference': ", potrms, call. = FALSE)
  if (any(opendata == potrdt$opendata))
    potrdt <- potrdt[which(potrdt$dataset == opendata), ]
  else if (any(as.character(opendata) == potrdt$id))
    potrdt <- potrdt[potrdt$id == as.numeric(opendata), ]
  else stop("Valid input to 'opendata' and 'reference': ", potrms, call. = FALSE)
  opendata <- unlist(strsplit(potrdt$dataset, split = "_"))[1]
  reference <- seq(from = as.Date("2013-01-01"), to = Sys.Date(), by = potrdt$by)
  reference <- substr(gsub(pattern = "-", replacement = "", x = reference), 1, nchar(potrdt$reference))
  subitem <- ifelse(potrdt$subitem == "", "", paste0("_", potrdt$subitem))
  if (missing(filename)) filename <- potrdt$dataset
  if (missing(destfile)) destfile <- filename
  else destfile <- paste0(destfile,"/",filename)
  i = length(reference)
  formals(download.file)$mode = "wb"
  while (file.exists(file) == FALSE || !i == 0) {
    link <- paste0(potrurl, opendata, "/", reference[i], subitem)
    file <- paste0(destfile, "-", reference[i], ".zip")
    try(download.file(url = link, destfile = file, ...), silent = TRUE)
    i <- i - 1
    }
}
