# A magic index in an array A[0...n - 1] is defined to be an index such that 
# A[i] = i. Given a sorted array of distinct integers, write a method to find a 
# magic index, if one exists, in array A.

def magic_index(sorted_array, start_idx = nil, end_idx = nil)
  return nil if sorted_array.empty?
  start_idx ||= 0
  end_idx ||= sorted_array.length - 1
  middle_idx = (start_idx + end_idx) / 2

  return middle_idx if sorted_array[middle_idx] == middle_idx

  p sorted_array[middle_idx]
  p middle_idx
  if sorted_array[middle_idx] > middle_idx
    magic_index(sorted_array, start_idx, middle_idx)
  else
    magic_index(sorted_array, middle_idx, end_idx)
  end
end

sorted_array = [-20, -10, -10, -5, 0, 5, 5, 8, 10]

p magic_index(sorted_array)
