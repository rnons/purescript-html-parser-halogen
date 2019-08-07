// https://stackoverflow.com/a/34064434
exports.htmlDecode = function(input) {
  var doc = new DOMParser().parseFromString(input, "text/html");
  return doc.documentElement.textContent;
};
