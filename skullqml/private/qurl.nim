proc setup*(self: QUrl, url: string, mode: QUrlParsingMode) =
  ## Setup a new QUrl
  self.vptr = dos_qurl_create(url.cstring, mode.cint)

proc toString*(self: QUrl): string =
  ## Return the url string
  let str: cstring = dos_qurl_to_string(self.vptr)
  result = $str
  dos_chararray_delete(str)
