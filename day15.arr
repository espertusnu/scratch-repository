use context dcic2024

fun my-sum(num-list :: List<Number>) -> Number block:
  doc: "get the sum of the numbers in the list"
  var total = 0
  for each(n from num-list):
    total := total + n
  end
  total
where:
  my-sum([list: 1, 2]) is 3
  my-sum([list:]) is 0
end

fun my-sum22(num-list :: List<Number>) -> Number block:
  doc: "get the sum of the 22s in the list"
  var total = 0
  for each(n from num-list):
    when n == 22:
      total := total + n
    end
  end
  total
where:
  my-sum22([list: 1, 2]) is 0
  my-sum22([list: 22, 30]) is 22
end

fun my-fun() -> String:
  if (1 > 2):
    "wtf"
  else:
    "aokay"
  end
end