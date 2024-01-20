# frozen_string_literal: true

BOARD_SIZE = 7

# Stores the
class Move
  TRANSLATIONS = [[-2, -1], [-2, 1], [-1, -2], [-1, 2], [1, -2], [1, 2], [2, -1], [2, 1]].freeze

  attr_reader :square, :visited, :legal_moves

  def initialize(square, visited = [])
    @square = square
    @visited = visited + [square]
    @legal_moves = []
  end

  def find_legal_moves
    TRANSLATIONS.each do |translation|
      new_square = [@square[0] + translation[0], @square[1] + translation[1]]
      next unless !@visited.include?(new_square) &&
                  new_square[0].between?(0, BOARD_SIZE) &&
                  new_square[1].between?(0, BOARD_SIZE)

      @legal_moves.push(Move.new(new_square, @visited))
    end
  end
end

def knight_moves(start, finish)
  queue = [Move.new(start)]

  shortest_path = nil

  until shortest_path
    next_move = queue.shift
    next_move.find_legal_moves
    queue += next_move.legal_moves
    shortest_path = check_queue(queue, finish)
  end

  shortest_path.visited
end

def check_queue(queue, finish)
  queue.each do |move|
    return move if move.square == finish
  end
  nil
end

# Tests
p knight_moves([0, 0], [1, 2])
p knight_moves([0, 0], [3, 3])
p knight_moves([3, 3], [0, 0])
p knight_moves([0, 0], [7, 7])
