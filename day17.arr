use context dcic2024

frequency = 3

fun every-third-element(lst :: List) -> List block:
  doc: "build a list with element 0, 3, etc. of the input list"
  var output = [list: ]
  var cnt = 0
  for each(elt from lst) block:
    spy: 
    cnt end
    when num-modulo(cnt, frequency) == 0:
      output := output + [list: elt]
    end
    cnt := cnt + 1
  end
  output
where:
  every-third-element([list: ]) is [list: ]
  every-third-element([list: 1, 3, 5]) is [list: 1]
  every-third-element([list: 1,3,5,7,11]) is [list: 1, 7]
end

