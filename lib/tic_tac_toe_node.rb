require_relative 'tic_tac_toe'

class TicTacToeNode
  NEXT_MARK = { x: :o, o: :x}

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @opponent = NEXT_MARK[@next_mover_mark]
    @prev_move_pos = prev_move_pos
  end

  attr_reader :board, :next_mover_mark, :prev_move_pos

  # This method generates an array of all moves that can be made after
  # the current move.
  private_constant :NEXT_MARK
  def children
    children_nodes = []
    @board.rows.each.with_index do |row, ri|
      next if row.none?(&:nil?)
      row.each.with_index do |col, ci|
        next unless col.nil?
        dupboard = @board.dup
        pos = [ri, ci]
        dupboard[pos] = @next_mover_mark
        new_node = TicTacToeNode.new(dupboard, @opponent, pos)
        children_nodes << new_node
      end
    end
    children_nodes
  end

  def losing_node?(evaluator)
    if @board.over?
      return true if @board.winner == NEXT_MARK[evaluator]
      return false if @board.winner.nil? || @board.winner == evaluator
    end

    self.children.all? { |child| child.losing_node?(evaluator) } ||
    self.children.any? { |child| child.losing_node? (evaluator) }
  end

  def winning_node?(evaluator)
    if @board.over?
      return true if @board.winner == evaluator
      return false if @board.winner.nil? || @board.winner == NEXT_MARK[evaluator]
    end

    self.children.any? { |child| child.winning_node?(evaluator) } ||
    self.children.all? { |child| child.winning_node?(evaluator) }
  end

end
