# frozen_string_literal: true

BOARD_SIZE = 2

def knight_moves(start, finish)
  available_squares = []
  0.upto(BOARD_SIZE) do |i|
    0.upto(BOARD_SIZE) do |j|
      available_squares.push([i, j])
    end
  end

  root = Node.new(start, available_squares, finish)
  p root.square

end

# Nodes in a graph representing the possible moves of the knight.
class Node
  @@translations = [[-2, -1], [-2, 1], [-1, -2], [-1, 2], [1, -2], [1, 2], [2, -1], [2, 1]]

  attr_accessor :square, :legal_moves

  def initialize(square, available_squares, finish)
    @square = square
    @legal_moves = square == finish ? [] : find_legal_moves(available_squares - [square], finish)
  end

  def find_legal_moves(available_squares, finish)
    moves = []
    return moves if available_squares.empty?

    @@translations.each do |translation|
      new_square = [@square[0] + translation[0], @square[1] + translation[1]]
      next unless available_squares.include?(new_square) &&
                  new_square[0].between?(0, BOARD_SIZE) &&
                  new_square[1].between?(0, BOARD_SIZE)

      moves.push(Node.new(new_square, available_squares, finish))
    end
    moves
  end
end

# Board is 0-7 by 0-7.
# I.e. [[0, 0], [0, 1]] is a1, b1.
# We won't convert to standard notation until the end.
# First goal: knight_moves([0,0], [1,2]) returns [[0,0], [1,2]]

# Initialize a set of squares on the board.
# List the possible translations of the knight piece from any given square.
# Set the knights starting position to 'start'.
#
# Recursively build the tree of possible moves from start to finish:
#   Base cases:
#   (Find the legal moves)
#   If we are at the destination - exit.
#   If there are no legal moves to unvisited squares - exit
#
#   Remove the current square from the list of squares (put a 'coin' on it).
#   Make a Node for current square.
#   Add all legal moves to Node.
#   Move to each legal move
#

# Testing
knight_moves([0, 0], [1, 2])
