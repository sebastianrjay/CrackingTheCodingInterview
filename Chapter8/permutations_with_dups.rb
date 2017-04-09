# Write a method to compute all permutations of a string whose characters are 
# not necessarily unique. The list of permutations should not have duplicates.

require_relative 'permutations_without_dups'

# Runs in O(n!) time and O(n!) space. Efficiency could be improved, since 
# duplicate permutations are generated and later filtered out.
p permutations_without_dups('abb')
p permutations_without_dups('abb').count == 3
