const utils = require("./lib/greeting-utils");
function greeting(name) {
  return utils.greet(name);
}
module.exports = { greeting };
