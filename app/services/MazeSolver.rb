class MazeSolver
  def initialize(board)
    @board = board
    @queue = []
    @connections = [[-1, 0], [0, 1], [1, 0], [0, -1]]
    @isConductive = false
  end

  def resolve
    initial_positions()
    while !@queue.empty? do
      position = @queue.pop
      @board[position[0]][position[1]] = "2"
      if (position[0] < @board.size - 1) 
        find_connections(position)
      else
        @isConductive = true
      end
    end
    return [@isConductive, @board]
  end

  def initial_positions
    @board[0].each_with_index do |value, index|
      if value == "1"
        @queue.unshift [0, index]
      end
    end
  end

  def find_connections(position)
    @connections.each do |value|
      next_field = position[0] + value[0]
      next_column = position[1] + value[1]
      if (next_field >= 0 && next_field < @board.size && next_column >= 0 && next_column < @board[0].size)
        next_position = @board[next_field][next_column]
        if (next_position == "1")
          @queue.unshift [next_field, next_column]
        end
      end
    end 
  end
end