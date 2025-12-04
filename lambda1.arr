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

BOOL-to-string(TRUE)
BOOL-to-string(FALSE)

# IF is the function that takes:
# * a BOOL (TRUE or FALSE)
# * an if-body
# * an else-body
# and returns the appropriate expression.
IF = lam(b, i, e): b(i, e) end

# Let's test it out...
IF(TRUE, "it was true", "it was false")  # "it was true"
IF(FALSE, "it was true", "it was false") # "it was false"

## Implement AND, OR, and NOT as functions.

# NOT is the function that takes a BOOL (TRUE or FALSE)
# and returns the other condition.

NOT = lam(b): IF(b, FALSE, TRUE) end

BOOL-to-string(NOT(TRUE)) # "true"

BOOL-to-string(NOT(FALSE)) # "false"

# OR is the function that takes two BOOLs and
# returns TRUE if 1 or more is TRUE, FALSE otherwise.

OR = lam(b1, b2):
  IF(b1, TRUE, b2)
end

BOOL-to-string(OR(TRUE, TRUE)) # "true"
BOOL-to-string(OR(TRUE, FALSE)) # "true"
BOOL-to-string(OR(FALSE, TRUE)) # "true"
BOOL-to-string(OR(FALSE, FALSE)) # "false"

# AND is the function that takes two BOOLs and
# returns TRUE if both are TRUE, FALSE otherwise.
AND = lam(b1, b2):
  IF(b1, b2, FALSE)
end

BOOL-to-string(AND(TRUE, TRUE)) # "true"
BOOL-to-string(AND(TRUE, FALSE)) # "false"
BOOL-to-string(AND(FALSE, TRUE)) # "false"
BOOL-to-string(AND(FALSE, FALSE)) # "false"

## Implement the natural numbers (0, 1, etc.) as functions.

# ZERO should take a function and an x value as arguments
# and apply the function to x zero times (i.e., return x).
ZERO = lam(f, x): x end

# ONE should take a function and an x value as arguments
# and apply the function to x one time (i.e., return f(x)).
ONE = lam(f, x): f(x) end

# Create helper function to render numbers.
NUM-to-string = lam(n):
  n(lam(x): x + 1 end, 0)
end

NUM-to-string(ZERO) # 0
NUM-to-string(ONE) # 1

# Create function to increment a number by 1.
INCREMENT = lam(n):
  lam(f, x): f(n(f, x)) end
end

NUM-to-string(INCREMENT(ZERO)) # 1
NUM-to-string(INCREMENT(ONE)) # 2

TWO = INCREMENT(ONE)
THREE = INCREMENT(TWO)
NUM-to-string(THREE) # 3

# Create a function to add two numbers.
ADDv1 = lam(n1, n2):
  n1(INCREMENT, n2)
end

ADD = lam(n1, n2):
  lam(f, x):
    n2-applications = n2(f, x)
    n2-then-n1-applied = n1(f, n2-applications)
    n2-then-n1-applied
  end
end

NUM-to-string(ADD(TWO, THREE)) # 5

# Create a function to multiply two numbers.
MUL = lam(n1, n2): 
  add-n2-to-y = lam(y): ADD(n2, y) end
  add-n2-n1-times = n1(add-n2-to-y, ZERO)
  add-n2-n1-times
end

NUM-to-string(MUL(TWO, THREE)) # 6

## Prepare to implement subtraction.

# Create a function that takes a number and
# returns TRUE if it is ZERO, FALSE otherwise.
EQUAL0 = lam(n):
  n(lam(x): FALSE end, TRUE)
end

BOOL-to-string(EQUAL0(ZERO)) # "true"
BOOL-to-string(EQUAL0(ONE)) # "false"

# Create PAIR, FIRST, and SECOND to build a data structure of two values.

# A pair is a function that takes a selector, which it applies to its two args.
PAIR = lam(a, b): 
  lam(s): s(a, b) end
end

FIRST = lam(p):
  p(lam(a, b): a end)
end

SECOND = lam(p):
  p(lam(a, b): b end)
end

ONE_TWO = PAIR(ONE, TWO)
NUM-to-string(FIRST(ONE_TWO)) # 1
NUM-to-string(SECOND(ONE_TWO)) # 2
