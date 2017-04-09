# Write a recursive function to multiply two positive integers without using the 
# * operator. You can use addition, subtraction and bit shifting, but you should 
# minimize the number of those operations.

# O(b) time; O(b) space
def multiply_recursively(a, b, cache = {})
  return 0 if a == 0 || b == 0

  cache[b - 1] ||= multiply_recursively(a, b - 1)

  a + cache[b - 1]
end

p multiply_recursively(12, 11)
p multiply_recursively(0, 1)
p multiply_recursively(2, 0)
