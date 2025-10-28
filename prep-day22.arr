use context dcic2024

data River:
  | merge(width :: Number, left :: River, right :: River)
  | stream(flow-rate :: Number)
end

# Example: A small river network
stream-a = stream(5)
stream-b = stream(8)
stream-c = stream(3)
merge-1 = merge(12, stream-a, stream-b)
main-river = merge(15, merge-1, stream-c)

#|
fun river-fun(r :: River) -> ???:
  cases (River) r:
    | merge(width, left, right) =>
      ... width ...
      ... river-fun(left) ...
      ... river-fun(right) ...
    | stream(flow) => ... flow ...
  end
end
|#

# Design a function count-streams that counts how many individual streams feed into a river network.
fun river-fun(river :: River) -> Number:
  doc: "counts the number of individual strings in a river"
  cases (River) river:
    | merge(width, left, right) =>
      river-fun(left) + river-fun(right)
    | stream(flow-rate) => 1
  end
where:
  river-fun(stream-a) is 1
  river-fun(merge-1) is 2
  river-fun(main-river) is 3
end

# Design a function max-width that finds the maximum width among all merge points in a river network.
fun max-width(river :: River) -> Number:
  doc: "finds the max width of all merge points in a network"
  cases (River) river:
    | merge(width, left, right) => num-max(left, right)
    | stream(flow-rate) => 0
  end
where:
  max-width(stream-a) is 0
  max-width(merge-1) is 2
  max-width(main-river) is 3
end
