use context dcic2024

data NumList:
| nl-empty
| nl-link(first :: Number, rest :: NumList)
end

#|
fun num-list-fun(nl :: NumList) -> ???:
  cases (NumList) nl:
    | nl-empty => ...
    | nl-link(first, rest) =>
      ... first ...
      ... num-list-fun(rest) ...
  end
end
|#

fun contains-num(nl :: NumList, num :: Number) -> Boolean:
  cases (NumList) nl:
    | nl-empty => false
    | nl-link(first, rest) =>
      if first == num:
        true
      else:
        contains-num(rest, num)
      end
  end
where:
  list123 = (nl-link(1, (nl-link(2, (nl-link(3, nl-empty))))))
  contains-num(list123, 1) is true
  contains-num(list123, 3) is true
  contains-num(list123, 0) is false
end

fun sum-num-list(nl :: NumList) -> Number:
  cases (NumList) nl:
    | nl-empty => 0
    | nl-link(first, rest) =>
      first + sum-num-list(rest)
  end
where:
  list123 = (nl-link(1, (nl-link(2, (nl-link(3, nl-empty))))))
  sum-num-list(nl-empty) is 0
  sum-num-list(list123) is 6
end

fun remove-3(nl :: NumList) -> NumList:
  cases (NumList) nl:
    | nl-empty => nl-empty
    | nl-link(first, rest) =>
      if first == 3:
        remove-3(rest)
      else:
        nl-link(first, remove-3(rest))
      end
  end
where:
  list123 = (nl-link(1, (nl-link(2, (nl-link(3, nl-empty))))))
  remove-3(nl-empty) is nl-empty
  remove-3(list123) is (nl-link(1, (nl-link(2, nl-empty))))
end

data NumNumList:
  | nnl-empty
  | nnl-link(first :: NumList, rest :: NumNumList)
end

fun sum-nnl(nnl :: NumNumList) -> NumList:
  cases (NumNumList) nnl:
    | nnl-empty => nl-empty
    | nnl-link(first, rest) =>
      nl-link(sum-num-list(first),
        sum-nnl(rest))
  end
where:
  list123 = (nl-link(1, (nl-link(2, (nl-link(3, nl-empty))))))
  list456 = (nl-link(4, (nl-link(5, (nl-link(6, nl-empty))))))
  sum-nnl(nnl-link(list123, nnl-link(list456, nnl-empty))) is (nl-link(6, nl-link(15, nl-empty)))
end

data StrList:
  | sl-empty
  | sl-link(first :: String, rest :: StrList)
end

#|
fun str-list-fun(sl :: StrList) -> ???:
  cases (StrList) sl:
    | sl-empty => ...
    | sl-link(first, rest) =>
      ... first ...
      ... str-list-fun(rest) ...
  end
end
|#