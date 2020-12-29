diverge = require "highland-diverge"

factory = (highland) ->
  highland().constructor.prototype.concurrentFlatMap = (concurrency, fn) ->
    throw new Error "Invalid concurrency value: #{concurrency}" unless concurrency >= 1
    @through(diverge(concurrency))
    .map (stream) -> stream.flatMap fn
    .merge()

  highland

module.exports = factory require "highland"