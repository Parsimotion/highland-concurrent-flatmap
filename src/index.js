const diverge = require("highland-diverge");

function factory(highland) {
  highland().constructor.prototype.concurrentFlatMap = function (concurrency, fn) {
    const parsedConcurrency = parseInt(String(concurrency));
    if (parsedConcurrency < 1) {
      throw new Error(`Invalid concurrency value: ${concurrency}`);
    }
    return this.through(diverge(parsedConcurrency))
      .map((stream) => stream.flatMap(fn))
      .merge();
  };
  return highland;
}

module.exports = factory(require("highland"));
