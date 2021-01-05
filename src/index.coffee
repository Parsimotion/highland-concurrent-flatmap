diverge = require "highland-diverge"

factory = (highland) ->
  highland().constructor.prototype.concurrentFlatMap = (concurrency, fn) ->
    parsedConcurrency = parseInt concurrency
    throw new Error "Invalid concurrency value: #{concurrency}" unless parsedConcurrency >= 1
    @through(diverge(parsedConcurrency))
    .map (stream) -> stream.flatMap fn
    .merge()

  highland

module.exports = factory require "highland"
