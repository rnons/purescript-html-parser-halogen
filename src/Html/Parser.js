exports.decodeHtmlEntity = function(input) {
  var DOMParser = DOMParser;
  if (!DOMParser) {
    var jsdom;
    try {
      jsdom = require("jsdom");
    } catch (_) {
      return input;
    }
    DOMParser = new jsdom.JSDOM().window.DOMParser;
  }

  // https://stackoverflow.com/a/34064434
  var doc = new DOMParser().parseFromString(input, "text/html");
  return doc.documentElement.textContent;
};
