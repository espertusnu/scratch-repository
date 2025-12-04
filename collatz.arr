use context dcic2024

fun collatz(n :: Number) -> Number:
  spy: n end
  if n <= 1:
    # If we've reached one, stop
    n
  else if num-modulo(n,2) == 0:
    # If n is even, divide it by 2
    collatz(n / 2)
  else:
    # If n is odd, triple it and add 1
    collatz((n * 3) + 1)
  end
end