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

# Design a function count-streams that counts how many 
# individual streams feed into a river network.
fun count-streams(r :: River) -> Number:
  doc: "counts the number of streams in a river network"
  cases (River) r:
    | merge(width, left, right) =>
      count-streams(left) + count-streams(right)
    | stream(flow) => 1
  end
where:
  count-streams(merge-1) is 2
  count-streams(main-river) is 3
end


# Design a function max-width that finds the maximum width 
# among all merge points in a river network.
fun max-width(r :: River) -> Number:
  doc: "finds the maximum width of the merge points in the network"
  cases (River) r:
    | merge(width, left, right) =>
      num-max(width, 
        num-max(max-width(left), max-width(right)))
    | stream(flow) => 0
  end
where:
  max-width(merge-1) is 12
  max-width(main-river) is 15
end

# Design a function widen-river that takes a river network 
# and a number, and returns a new network where every 
# merge point is wider by that amount.
fun widen-river(r :: River, n :: Number) -> River:
  doc: "creates a new river where each merge point is wider by n"
  cases (River) r:
    | merge(width, left, right) =>
      merge(
        # new width
        width + n, 
        # new left
        widen-river(left, n), 
        # new right
        widen-river(right, n))
    | stream(flow) => r
  end
where:
  wider-river = merge(18, merge(15, stream-a, stream-b), stream-c)
  widen-river(main-river, 3) is wider-river
end


# Design a function cap-flow that takes a river network
# and returns a new network where no stream has 
# flow-rate above 10 (cap any higher values at 10).
MAX-FLOW = 10
fun cap-flow(r :: River) -> River:
  doc: "creates a new river where flow is capped at 10"
  cases (River) r:
    | merge(width, left, right) => 
      merge(width, cap-flow(left), cap-flow(right))
    | stream(flow) => stream(num-min(flow, MAX-FLOW))
  end
where:
  original-river = merge(20, stream(MAX-FLOW + 1), stream(MAX-FLOW - 1))
  capped-river = merge(20, stream(MAX-FLOW), stream(MAX-FLOW - 1))
  cap-flow(original-river) is capped-river
end

# Design a function has-large-stream that returns true if
# any stream in the network has flow-rate greater than 6.
HIGH-FLOW = 7
fun has-large-stream(r :: River) -> Boolean:
  doc: "finds whether any stream in a river has flow greater than 6"
  cases (River) r:
    | merge(width, left, right) => 
      has-large-stream(left) or has-large-stream(right)
    | stream(flow) => flow >= HIGH-FLOW
  end
where:
  has-large-stream(stream-a) is false
  has-large-stream(stream-b) is true
  has-large-stream(stream-c) is false
  has-large-stream(merge-1) is true
  has-large-stream(main-river) is true
end