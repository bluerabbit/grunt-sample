class Animal
  constructor: (@name) ->

  move: (meters) ->
    alert @name + " moved #{meters}m."

  ok: ->
    true

class Snake extends Animal
  move: ->
    alert "Slithering..."
    super 5



