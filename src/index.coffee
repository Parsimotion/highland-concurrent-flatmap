diverge = require "highland-diverge"

factory = (highland) ->
  highland().constructor.prototype.concurrentFlatMap = (concurrency, fn) ->
    @through(diverge(concurrency))
    .map (stream) -> stream.flatMap fn
    .merge()

  highland

module.exports = factory require "highland"