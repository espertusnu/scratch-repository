use context dcic2024

## Intro code

data BST:
  | leaf
  | node(key :: Number, val :: String, left :: BST, right :: BST)
end

# Invariant: keys are unique, and all nodes in the left
# subtree have keys less than the key in the current node,
# all nodes in the right subtree have keys greater than
# the key in the current node

BST0 = leaf
BST1 = node(1, "hello", BST0, BST0)
BST2 = node(5, "bye", BST1, BST0)
BST3 = node(6, "bye", BST2, node(10, "cs2000", BST0, BST0))

fun height(bst :: BST) -> Number:
  cases (BST) bst:
    | leaf => 0
    | node(k, v, left, right) => 
        1 + num-max(height(left), height(right))
  end
where:
  height(BST0) is 0
  height(BST1) is 1
  height(BST2) is 2
  height(BST3) is 3
end

## Class exercise 1
##
## The main goal of a BST is to be able to look up values at a given key. 
## Design a function retrieve that takes a BST, a Number, and returns an
## Option<String> -- if the given number exists as a key in the tree, your 
## function should return some(v) where v is the string value that is on 
## the node with the key. If the given number doesn't exist, your function
## should return none.

fun retrieve(bst :: BST, goal-num :: Number) -> Option<String>:
  doc: "finds the key associated with num in bst or returns none"
  cases (BST) bst:
    | leaf => none
    | node(key, val, left, right) =>
      if goal-num == key:
        some(val)
      else if key < goal-num:
        # Our goal number is bigger than the current node's key,
        # so we should traverse the right subtree.
        retrieve(right, goal-num)
      else:
        # Our goal number is less than the current node's key,
        # so we should traverse the left subtree.
        retrieve(left, goal-num)
      end
  end
where:
  retrieve(BST3, 6) is some("bye") # base case
  retrieve(BST3, 1) is some("hello") # left recursion
  retrieve(BST3, 10) is some("cs2000") # right recursion
  retrieve(BST3, 3) is none # number not in tree
end
  
## Class exercise 2
##
## In order for BSTs to have the performance characteristics that define
## them, they have to be balanced....Design a function is-balanced that
## should take a BST and return a boolean that indicates if the tree is
## balanced: this means that at every level, the height of the left and
## right subtrees differs by at most 1.

fun is-balanced(bst :: BST) -> Boolean:
  doc: "finds whether a BST is balanced"
  cases (BST) bst:
    | leaf => true
    | node(key, val, left, right) =>
      (num-abs(height(left) - height(right)) <= 1) and
      is-balanced(left) and is-balanced(right)
  end
where:
  is-balanced(BST3) is true
  # This tree only has left nodes and is unbalanced
  is-balanced(node(1, "root", node(2, "left1", node(3, "left2", leaf, leaf), leaf), leaf)) is false
end
  

## Class exercise 3
##
## Design a data definition Arith that allows you to represent:
## * numbers, 
## * addition of two arithmetic expressions
## * multiplication of two arithmetic expressions
## * division of two arithmetic expressions
## * subtraction of two arithmetic expressions
##
## This should be a binary tree with one leaf constructor (for 
## numbers) and four node constructors (for the four types of 
## binary operations).