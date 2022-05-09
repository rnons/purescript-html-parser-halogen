// For a detailed explanation regarding each configuration property, visit:
// https://jestjs.io/docs/en/configuration.html

module.exports = {
  testEnvironment: "jsdom",

  // An array of directory names to be searched recursively up from the requiring module's location
  moduleDirectories: ["node_modules", "output"],

  // An array of regexp pattern strings that are matched against all test paths, matched tests are skipped
  testPathIgnorePatterns: ["/node_modules/", "/bower_components/", ".spago"]
};
