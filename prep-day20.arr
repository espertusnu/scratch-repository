use context dcic2024

fun add-till-zero(my-list :: List<Number>) -> Number block:
  doc: "add up the numbers in the list until the number 0 is found"
  var total = 0
  var done = false
  for each(n from my-list):
    when not(done):
      if n == 0:
        done := true
      else:
        total := total + n
      end
    end
  end
  total
where:
  add-till-zero([list: 7, 3, 0, 5]) is 10
  add-till-zero([list: 3, 0, 5]) is 3
  add-till-zero([list: 0, 5]) is 0
  add-till-zero([list: ]) is 0
end

LEN-LIMIT = 6

fun strings-less-than(my-list :: List<Number>) -> List<Number>:
  doc: "produces a list of strings shorter than LEN-LIMIT"
  cases (List) my-list:
    | empty => [list: ]
    | link(f, r) =>
      if (string-length(f) < LEN-LIMIT):
        link(f, strings-less-than(r))
      else:
        strings-less-than(r)
      end
  end
where:
  strings-less-than([list: "hello", "beautiful", "world"]) is [list: "hello",  "world"]
end

fun strings-less-than2(my-list :: List<String>) -> List<String> block:
  doc: "produces a list of strings shorter than LEN-LIMIT"
  var result = empty
  for each(s from my-list):
    when string-length(s) < LEN-LIMIT:
      result := result + [list: s]
    end
  end
  result
where:
  strings-less-than2([list: "hello", "beautiful", "world"]) is [list: "hello",  "world"]
end

fun find-error-suffix(my-list :: List<String>) -> List<String>:
  doc: "produces a list of strings that occur after the 'error' string"
  cases (List) my-list:
    | empty => empty
    | link(f, r) =>
      if (f == "error"):
        r
      else:
        find-error-suffix(r)
      end
  end
where:
  find-error-suffix([list: "okay"]) is empty
  find-error-suffix([list: "okay1", "error", "okay2"]) is [list: "okay2"]
end

fun find-error-suffix2(my-list :: List<String>) -> List<String> block:
  doc: "produces a list of strings that occur after the 'error' string"
  var result = empty
  var after-error = false
  for each(s from my-list) block:
    when after-error:
      result := result + [list: s]
    end
    when s == "error":
      after-error := true
    end
  end
  result
where:
  find-error-suffix2([list: "okay"]) is empty
  find-error-suffix2([list: "okay1", "error", "okay2"]) is [list: "okay2"]
end