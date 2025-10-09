use context dcic2024

import lists as L

## Exercise 1

fun my-doubles(numbers :: List<Number>) -> List<Number> block:
  doc: "doubles all the numbers in the list"
  var my-list = empty
  for each(n from numbers):
    my-list := my-list + [list: 2 * n]
  end
  my-list
where:
  my-doubles([list: 1, 2, 3]) is [list: 2, 4, 6]
end

## Exercise 2

fun my-doubles-map(numbers :: List<Number>) -> List<Number>:
  doc: "doubles all the numbers in the list"
  L.map(
    lam(n :: Number) -> Number: 2 * n end,
  numbers)
where:
my-doubles-map([list: 1, 2, 3]) is [list: 2, 4, 6]
end

## Exercise 3

fun my-string-lens(strings :: List<String>) -> List<Number> block:
  doc: "creates a list of the lengths of the strings"
  var my-list = empty
  for each(s from strings):
    my-list := my-list + [list: string-length(s)]
  end
  my-list
where:
  my-string-lens(empty) is empty
  my-string-lens([list: "hi", "there"]) is [list: 2, 5]
end

## Exercise 4

fun my-string-lens-map(strings :: List<String>) -> List<Number>:
  doc: "creates a list of the lengths of the strings"
  L.map(string-length, strings)
where:
  my-string-lens-map(empty) is empty
  my-string-lens-map([list: "hi", "there"]) is [list: 2, 5]
end

## Exercise 5

fun my-pos-nums(num-list :: List<Number>) -> List<Number> block:
  doc: "creates a list with the positive numbers in num-list"
  var my-list = empty
  for each(n from num-list):
    when n > 0:
      my-list := my-list + [list: n]
    end
  end
  my-list
where:
  my-pos-nums(empty) is empty
  my-pos-nums([list: -5, 5, 0]) is [list: 5]
end

## Exercise 6

fun my-pos-nums-map(num-list :: List<Number>) -> List<Number>:
  doc: "creates a list with the positive numbers in num-list"
  L.filter(
    lam(n :: Number) -> Boolean: n > 0 end,
    num-list)
where:
  my-pos-nums-map(empty) is empty
  my-pos-nums-map([list: -5, 5, 0]) is [list: 5]
end

## Exercise 7

fun my-alternating(start-list :: List) -> List block:
  doc: "creates a list of every other elment from start-list"
  var my-list = empty
  var take-next = true
  for each(elt from start-list) block:
    when take-next:
      my-list := my-list + [list: elt]
    end
    take-next := not(take-next)
  end
  my-list
where:
  my-alternating(empty) is empty
  my-alternating([list: -5, 5, 0]) is [list: -5, 0]
end

## Exercise 8

# This cannot be done in a straightforward way without a loop.
# Here's a convoluted solution (not recommended).

fun my-alternating-map(start-list :: List) -> List:
  doc: "creates a list of every other elment from start-list"

  # Create [list: 0, 1, 2, ..., (n-1)] where n is the length of start-list
  list-of-pos = L.range(0, L.length(start-list))

  # Create list of lists, where element 0 is [list: 0, elt0],
  # where elt0 is the first element of start-list. The outer
  # list has n elements, where n is the length of start-list
  list-of-lists = L.map2(
    lam(x, y) -> List: [list: x, y] end,
    list-of-pos,
    start-list)
  
  # Keep only the inner lists whose first element (position) is even
  even-lists = L.filter(
    lam(lst :: List) -> Boolean: 
      pos = lst.get(0)
      num-modulo(pos, 2) == 0
    end,
    list-of-lists)
  
  # Keep only the elements from the original list, dropping the positions
  L.map(
    lam(lst :: List): lst.get(1) end,
    even-lists)
  
where:
  my-alternating-map(empty) is empty
  my-alternating-map([list: -5, 5, 0]) is [list: -5, 0]
end

## Exercise 9

fun my-running-sum(num-list :: List<Number>) -> List<Number> block:
  doc: "creates a list with the running total of elements in num-list"
  var my-list = empty
  var total = 0
  for each(num from num-list) block:
    total := total + num
    my-list := my-list + [list: total]
  end
  my-list
where:
  my-running-sum(empty) is empty
  my-running-sum([list: -5, 5, 0]) is [list: -5, 0, 0]
  my-running-sum([list: 1, 2, 3]) is [list: 1, 3, 6]
end

## Exercise 10

# There is no straightforward way to do this.
