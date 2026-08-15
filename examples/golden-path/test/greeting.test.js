const assert = require("assert");
const { greeting } = require("../src/index.js");
const test = require("node:test");

test("greeting(name) returns a personalized hello", () => {
  assert.strictEqual(greeting("World"), "Hello, World!");
});
