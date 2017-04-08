# A child is running up a staircase with n steps and can hop either 1 step, 2 
# steps, or 3 steps at a time. Implement a method to count how many possible 
# ways the child can run up the stairs.

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

# BONUS: A child is running up a staircase with n steps and can hop between 1 
# and m steps at a time. Implement a method to count how many possible ways the 
# child can run up the stairs, given n and m.

def adjustable_max_distance_triple_step(n, m, memo = {})
  return nil if n < 0 || m < 0
  return 0 if n == 0 || m == 0
  return 1 if n == 1
  if n == 2
    return 2 if m >= 2
    return 1 if m == 1
  end
  if n == 3
    return 4 if m >= 3
    return 3 if m == 2
    return 1 if m == 1
  end

  memo[n] ||= (1..m).map do |step_dist|
      adjustable_max_distance_triple_step(step_dist, m, memo) * 
        adjustable_max_distance_triple_step(n - step_dist, m, memo)
    end.reduce(&:+)
end

p triple_step(28)
p adjustable_max_distance_triple_step(28, 5)
