exports.decodeHtmlEntity = function(input) {
  if (typeof DOMParser === "undefined") {
    return input;
  }

  // Leading whitespaces are stripped by DOMParser
  var matches = /^\s+/.exec(input);
  var space = "";
  if (matches) {
    space = matches[0];
  }

  // https://stackoverflow.com/a/34064434
  var doc = new DOMParser().parseFromString(input, "text/html");
  return space + doc.documentElement.textContent;
};
