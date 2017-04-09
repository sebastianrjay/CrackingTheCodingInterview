# Write a method to compute all permutations of a string of unique characters.

require 'set'

class LetterNode
  attr_reader :children, :letter, :parent
  def initialize(letter, parent_node)
    @children = []
    @letter = letter
    @parent = parent_node
  end

  def add_child(node)
    @children << node
  end

  def is_leaf?
    @children.empty?
  end
end

class PermutationTree
  attr_reader :first_letter, :root, :word
  def initialize(word, first_letter)
    @first_letter, @word = first_letter, word
    @root = LetterNode.new(first_letter, nil)
    build_tree(@root, @first_letter, @word)
  end

  def get_permutations
    all_leaf_nodes.map { |leaf_node| get_represented_permutation(leaf_node) }
  end

  private

  def all_leaf_nodes
    all_leaves, not_yet_visited, visited = [], [], Set.new
    not_yet_visited << @root

    until not_yet_visited.empty?
      next_node = not_yet_visited.shift
      visited << next_node
      all_leaves << next_node if next_node.is_leaf?
      next_node.children.each do |child|
        not_yet_visited << child unless visited.include?(child)
      end
    end

    all_leaves
  end

  def build_tree(current_node, current_letter, current_word_substring)
    next_word_substring = current_word_substring.delete(current_letter)

    next_word_substring.chars.each do |next_letter|
      next_node = LetterNode.new(next_letter, current_node)
      current_node.add_child(next_node)
      build_tree(next_node, next_letter, next_word_substring)
    end
  end

  def get_represented_permutation(leaf_node)
    current_node, letters = leaf_node, []

    until current_node.nil?
      letters << current_node.letter
      current_node = current_node.parent
    end

    letters.reverse.join
  end
end

# Runs in O(n!) time and O(n!) space
def permutations_without_dups(string_of_unique_chars)
  string_of_unique_chars.chars.reduce([]) do |all_permutations, char|
    all_permutations +=
      PermutationTree.new(string_of_unique_chars, char).get_permutations 
  end
end

p permutations_without_dups('abcd')
p permutations_without_dups('abc')
p permutations_without_dups('abcd').count == 24
p permutations_without_dups('abc').count == 6
