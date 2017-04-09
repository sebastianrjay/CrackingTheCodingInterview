# A child is running up a staircase with n steps and can hop either 1 step, 2 
# steps, or 3 steps at a time. Implement a method to count how many possible 
# ways the child can run up the stairs.

# O(n) time and O(n) space.
def triple_step(n, memo = {})
  return nil if n < 0
  return 0 if n == 0
  return 1 if n == 1
  return 2 if n == 2
  return 4 if n == 3

  memo[n] ||=
    triple_step(n - 1, memo) + 
    (triple_step(2, memo) * triple_step(n - 2, memo)) +
    (triple_step(3, memo) * triple_step(n - 3, memo))
end

p triple_step(28)
