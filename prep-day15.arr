use context dcic2024

# Exercise 1

fun my-product(num-list :: List<Number>) -> Number block:
  doc: "calculates the product of the numbers"
  var product = 1
  for each(n from num-list):
    product := product * n
  end
  product
where:
  my-product([list: 0, 1, 2]) is 0
  my-product([list: 1, 2, 3, 4]) is 24
end

# Exercise 2

fun is-even(n :: Number) -> Boolean:
  doc: "checks if a number is even"
  num-modulo(n, 2) == 0
where:
  is-even(1) is false
  is-even(2) is true
end

fun sum-even-numbers(num-list :: List<Number>) -> Number block:
  doc: "adds up the even numbers in the list"
  var total = 0
  for each(n from num-list):
    if is-even(n):
      total := total + n
    else:
      total := total + 0
    end
  end
  total
where:
  sum-even-numbers([list: 0, 1, 2]) is 2
  sum-even-numbers([list: 1, 2, 3, 4]) is 6
end

# Exercise 3

fun my-length(num-list :: List) -> Number block:
  doc: "counts the numbers in a list"
  var len = 0
  for each(n from num-list):
    len := len + 1
  end
  len
where:
  my-length([list:]) is 0
  my-length([list: 0, 1, 2]) is 3
  my-length([list: 1, 2, 3, 4]) is 4
end

# Exercise 4

fun any-negative(num-list :: List<Number>) -> Boolean block:
  doc: "checks if any numbers in the list are negative"
  var result = false
  for each(n from num-list):
    if n < 0:
      result := true
    else:
      result := result
    end
  end
  result
where:
  any-negative([list:]) is false
  any-negative([list: 0, 1, 2]) is false
  any-negative([list: 1, 2, -3, 4]) is true
end

# Exercise 5

fun all-short-words(word-list :: List<String>) -> Boolean block:
  doc: "checks if all strings in the list have 4 or fewer characters"
  var result = true
  for each(word from word-list):
    if string-length(word) > 4:
      result := false
    else:
      result := result
    end
  end
  result
where:
  all-short-words([list: ]) is true
  all-short-words([list: "hey", "you"]) is true
  all-short-words([list: "longest", "word"]) is false
end

# Exercise 6

