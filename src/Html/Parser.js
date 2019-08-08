exports.decodeHtmlEntity = function(input) {
  if (!DOMParser) {
    return input;
  }

  // https://stackoverflow.com/a/34064434
  var doc = new DOMParser().parseFromString(input, "text/html");
  return doc.documentElement.textContent;
};
