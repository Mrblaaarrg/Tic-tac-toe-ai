require_relative 'tic_tac_toe_node'


class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    node = TicTacToeNode.new(game.board, mark)
    # node.children.each { |child| return child.prev_move_pos if child.winning_node?(mark) }
    # node.children
    #   .reject { |child| child.losing_node?(mark) }
    #   .first
    #   .prev_move_pos

    possible_moves = node.children.shuffle
    target_node = possible_moves.find { |child| child.winning_node?(mark) }
    return target_node.prev_move_pos if target_node
    target_node = possible_moves.find { |child| !child.losing_node?(mark) }
    return target_node.prev_move_pos if target_node
    raise "Error, this is impossible, I am PERFECT!"
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
