use context dcic2024

## See https://neu-pdi.github.io/cs2000-public-resources/days/X%CE%BBY
## This uses a different version of IF.

TRUE = lam(x,y): x() end
FALSE = lam(x,y): y() end
fun tobool(cb):
  cb(lam(): true end, lam(): false end)
end

IF = lam(c,t,e): c(t,e) end
AND = lam(b1, b2): b1(lam(): b2 end, lam(): FALSE end) end
OR = lam(b1, b2): b1(lam(): TRUE end, lam(): b2 end) end
NOT = lam(b): b(lam(): FALSE end, lam(): TRUE end) end

ZERO = lam(f, x): x end
ONE = lam(f, x): f(x) end
TWO = lam(f, x): f(f(x)) end
fun ofnum(n :: Number):
  lam(f, x):
    fun r(m):
      if m == 0:
        x
      else:
        f(r(m - 1))
      end
    end
    r(n)
  end
end
fun tonum(cn) -> Number:
  cn(lam(y): y + 1 end, 0)
end

PAIR = lam(a,b): lam(z): z(a,b) end end
FIRST = lam(p): p(lam(a,b): a end) end
SECOND = lam(p): p(lam(a,b): b end) end

ADD = lam(n1, n2): lam(f, x): n2(f, n1(f, x)) end end
MUL = lam(n1, n2): n1(lam(y): ADD(n2, y) end, ZERO) end
MINUS1 = lam(n): lam(f,x): FIRST(n(lam(y): PAIR(SECOND(y), f(SECOND(y))) end, PAIR(x,x))) end end

EQUAL0 = lam(n): n(lam(y): FALSE end, TRUE) end


## Factorial

# Ordinary factorial
fun factorial(n):
  doc: "Returns n! for n >= 0"
  if n == 0:
    1
  else:
    n * factorial(n - 1)
  end
where:
  factorial(0) is 1
  factorial(3) is 6
end

# Lambda Calculus factorial

FACT1 = lam(rcall, n): 
  IF(EQUAL0(n),
  lam(): ONE end,
  lam(): MUL(n, rcall(rcall, MINUS1(n))) end)
end

FACT = lam(n):
  FACT1(FACT1, n)
end

check:
  THREE = ADD(TWO, ONE)
  SIX = ADD(THREE, THREE)
  tonum(FACT(ZERO)) is 1
  tonum(FACT(THREE)) is 6
end