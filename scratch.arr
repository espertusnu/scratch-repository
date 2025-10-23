use context dcic2024

data NumList:
| nl-empty
| nl-link(first :: Number, rest :: NumList)
end

list1 = nl-link(1, nl-empty)
list12 = nl-link(1, nl-link(2, nl-empty))

#|
fun my-fun(nl: NumList) -> ??:
  doc: "describe this function"
  cases (NumList) nl:
      nl-empty => ??
      nl-link(first, rest) =>
      ...first...
      ... my-fun(rest)...
  end
where:
  list123 = nl-link(1, nl-link(2, nl-link(3, nl-empty)))
end
|#

fun count-sevens(nl :: NumList) -> Number:
  doc: "counts the number of 7s in the list"
  cases (NumList) nl:
    | nl-empty => 0
    | nl-link(first, rest) =>
      if first == 7:
        # Yay! There's at least one 7.
        1 + count-sevens(rest)
      else:
        # No 7 here. Maybe there are 7s later.
        count-sevens(rest)
      end
  end
where:
  list123 = nl-link(1, nl-link(2, nl-link(3, nl-empty)))
  list173 = nl-link(1, nl-link(7, nl-link(3, nl-empty)))
  count-sevens(list123) is 0
  count-sevens(list173) is 1
  count-sevens(nl-empty) is 0
end

fun remove-3s(nl :: NumList) -> NumList:
  doc: "returns the list without the 3s"
  cases (NumList) nl:
    | nl-empty => nl-empty
    | nl-link(first, rest) =>
      if first == 3:
        remove-3s(rest)
      else:
        nl-link(first, remove-3s(rest))
      end
  end
where:
  list123 = nl-link(1, nl-link(2, nl-link(3, nl-empty)))
  remove-3s(list123) is nl-link(1, nl-link(2, nl-empty))
  remove-3s(nl-empty) is nl-empty
end