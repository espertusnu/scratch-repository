use context dcic2024

import lists as L

fun my-doubles-map(num-list :: List<Number>) -> List<Number>:
  doc: "builds a list of numbers twice the size of numbers in the original list"
  L.map(
    lam(num :: Number) -> Number : 2 * num end,
    num-list)
where:
  my-doubles-map([list: 1, 2, 3]) is [list: 2, 4, 6]
end