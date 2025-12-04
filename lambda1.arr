use context dcic2024

## Implement TRUE, FALSE, and IF as functions.

# TRUE is the function that returns the first of its two arguments.
TRUE = lam(x, y): x end

# FALSE is the function that returns the second of its two arguments.
FALSE = lam(x, y): y end

# Create helper method to render BOOL values.
BOOL-to-string = lam(c):
  c("true", "false")
end

check:
  BOOL-to-string(TRUE) is "true"
  BOOL-to-string(FALSE) is "false"
end

# IF is the function that takes:
# * a BOOL (TRUE or FALSE)
# * an if-body
# * an else-body
# and returns the appropriate expression.
IF = lam(b, i, e): b(i, e) end

check:
  IF(TRUE, "it was true", "it was false") is "it was true"
  IF(FALSE, "it was true", "it was false") is "it was false"
end

## Implement MAKE-PAIR, FIRST, and SECOND

# A PAIR is a function that takes a "selector" and returns 
# the appropriate item.
MAKE-PAIR = lam(a, b): 
  lam(s): s(a, b) end
end

FIRST = lam(p):
  p(lam(x, y): x end)
end

SECOND = lam(p):
  p(lam(x, y): y end)
end

check:
  my-pair = MAKE-PAIR(1, 100)
  FIRST(my-pair) is 1
  SECOND(my-pair) is 100
end

## Implement AND, OR, and NOT as functions.

# NOT is the function that takes a BOOL (TRUE or FALSE)
# and returns the other condition.

NOT = lam(b): IF(b, FALSE, TRUE) end

# OR is the function that takes two BOOLs and
# returns TRUE if 1 or more is TRUE, FALSE otherwise.

OR = lam(b1, b2):
  IF(b1, TRUE, b2)
end

check:
  BOOL-to-string(OR(TRUE, TRUE)) is "true"
  BOOL-to-string(OR(TRUE, FALSE)) is "true"
  BOOL-to-string(OR(FALSE, TRUE)) is "true"
  BOOL-to-string(OR(FALSE, FALSE)) is "false"
end

# AND is the function that takes two BOOLs and
# returns TRUE if both are TRUE, FALSE otherwise.
AND = lam(b1, b2):
  IF(b1, b2, FALSE)
end

check:
  BOOL-to-string(AND(TRUE, TRUE)) is "true"
  BOOL-to-string(AND(TRUE, FALSE)) is "false"
  BOOL-to-string(AND(FALSE, TRUE)) is "false"
  BOOL-to-string(AND(FALSE, FALSE)) is "false"
end

## Implement the natural numbers (0, 1, etc.) as functions.

# ZERO should take a function and an x value as arguments
# and apply the function to x zero times (i.e., return x).
ZERO = lam(f, x): x end

# ONE should take a function and an x value as arguments
# and apply the function to x one time (i.e., return f(x)).
ONE = lam(f, x): f(x) end

# Create helper function to render numbers.
NUM-to-int = lam(n):
  n(lam(x): x + 1 end, 0)
end

check:
  NUM-to-int(ZERO) is 0
  NUM-to-int(ONE) is 1
end

EQUAL0 = lam(n):
  n(lam(x): FALSE end, TRUE)
end

check:
  BOOL-to-string(EQUAL0(ZERO)) # "true"
  BOOL-to-string(EQUAL0(ONE)) # "false"
end

# Create function to increment a number by 1.
INCREMENT = lam(n):
  lam(f, x): f(n(f, x)) end
end

check:
  NUM-to-int(INCREMENT(ZERO)) is 1
  NUM-to-int(INCREMENT(ONE)) is 2
end

TWO = INCREMENT(ONE)
THREE = INCREMENT(TWO)
check:
  NUM-to-int(THREE) is 3
end

# Create a function to add two numbers.
ADD = lam(n1, n2):
  lam(f, x):
    n2-applications = n2(f, x)
    n2-then-n1-applied = n1(f, n2-applications)
    n2-then-n1-applied
  end
end

check:
  NUM-to-int(ADD(TWO, THREE)) is 5
end

# Create a function to multiply two numbers.
MUL = lam(n1, n2): 
  add-n2-to-y = lam(y): ADD(n2, y) end
  add-n2-n1-times = n1(add-n2-to-y, ZERO)
  add-n2-n1-times
end

check:
  NUM-to-int(MUL(TWO, THREE)) is 6
end

## Prepare to implement subtraction.

# Convert the pair (x,y) to the pair (y,y+1)
PRED-HELPER = lam(pair):
  MAKE-PAIR(SECOND(pair), INCREMENT(SECOND(pair)))
end

pair12 = MAKE-PAIR(ONE, TWO)
check:
  NUM-to-int(FIRST(pair12)) is 1
  NUM-to-int(SECOND(pair12)) is 2
  NUM-to-int(FIRST(PRED-HELPER(pair12))) is 2
end

MINUS1 = lam(n):
  nth-pair = n(PRED-HELPER, MAKE-PAIR(ZERO, ZERO))
  FIRST(nth-pair)
end

check:
  NUM-to-int(MINUS1(ONE)) is 0
  NUM-to-int(MINUS1(THREE)) is 2
end

## Challanges

# Implement IS-ZERO, which takes a NUMBER and returns TRUE
# if it is ZERO, FALSE otherwise. It cannot use NUM-to-int
# or int-to-NUM except to check your answer
fun EQUAL0(n):
  n(lam(x): false end, TRUE)
end

check:
  BOOL-to-string(IS-ZERO(ZERO)) is "true"
end

# Implement int-to-NUM, which takes a regular positive
# integer and returns a Church numeral. Hint: Use recursion.
# You can use regular if, else, etc.
fun int-to-NUM(i):
  if i == 0:
    ZERO
  else:
    INCREMENT(int-to-NUM(i - 1))
  end
end

check:
  NUM-to-int(int-to-NUM(0)) is 0
  NUM-to-int(int-to-NUM(10)) is 10
end

# Implement subtraction by decrementing n1 n2 times.
# You cannot use NUM-to-int or int-to-NUM except to check your
# answer.
SUB = lam(n1, n2):
  n2(MINUS1, n1)
end

check:
  NUM-to-int(SUB(THREE, TWO)) is 1
end