
class ComputerPlayer

  attr_reader :name, :piece

  def initialize(name, piece, skill = :novice)
    @name, @piece, @skill = name, piece, skill
  end

  def get_move(game)
    return winning_move(game) unless winning_move(game).nil?
    return block_move(game) unless @skill == :beginner || block_move(game).nil?
    return advanced_move(game) if @skill == :expert && !advanced_move(game).nil?
    random_move(game)
  end

  def winning_move(game)
    game.valid_moves.each do |pos|
      return pos if game.winning_move?(pos, @piece)
    end
    nil
  end

  def random_move(game)
    game.valid_moves.sample
  end

  def block_move(game)
    game.valid_moves.each do |pos|
      return pos if game.winning_move?(pos, determine_opponent(game).piece)
    end
    nil
  end

  def advanced_move(game)
    response_hash = {
      [[nil, nil, nil],    [nil, nil, nil],     [nil, nil, nil]]    => [1, 1],

      [[nil, nil, nil],    [:op, @piece , nil], [nil, nil, nil]]    => [2, 2],
      [[nil, :op, nil],    [nil, @piece, nil],  [nil, nil, nil]]    => [2, 0],
      [[nil, nil, nil],    [nil, @piece, :op],  [nil, nil, nil]]    => [0, 0],
      [[nil, nil, nil],    [nil, @piece, nil],  [nil, :op, nil]]    => [0, 2],

      [[:op, nil, nil],    [nil, @piece, nil],  [nil, nil, nil]]    => [2, 2],
      [[nil, nil, :op],    [nil, @piece, nil],  [nil, nil, nil]]    => [2, 0],
      [[nil, nil, nil],    [nil, @piece, nil],  [:op, nil, nil]]    => [0, 2],
      [[nil, nil, nil],    [nil, @piece, nil],  [nil, nil, :op]]    => [0, 0],

      [[nil, :op, @piece], [nil, @piece, nil],  [:op, nil, nil]]    => [2, 2],
      [[:op, nil, nil],    [nil, @piece, :op],  [nil, nil, @piece]] => [2, 0],
      [[@piece, nil, nil], [:op, @piece, nil],  [nil, nil, :op]]    => [0, 2],
      [[nil, nil, :op],    [nil, @piece, nil],  [@piece, :op, nil]] => [0, 0],

      [[nil, nil, nil],    [nil, :op, nil],     [nil, nil, nil]]    => [2, 0],

      [[nil, nil, :op],    [nil, :op, nil],     [@piece, nil, nil]] => [0, 0],

      [[:op, nil, nil],    [nil, nil, nil],     [nil, nil, nil]]    => [1, 1],
      [[nil, nil, :op],    [nil, nil, nil],     [nil, nil, nil]]    => [1, 1],
      [[nil, nil, nil],    [nil, nil, nil],     [:op, nil, nil]]    => [1, 1],
      [[nil, nil, nil],    [nil, nil, nil],     [nil, nil, :op]]    => [1, 1],

      [[:op, nil, nil],    [nil, @piece, nil],  [nil, nil, :op]]    => [1, 0],
      [[nil, nil, :op],    [nil, @piece, nil],  [:op, nil, nil]]    => [0, 1],
      [[nil, nil, :op],    [nil, @piece, nil],  [:op, nil, nil]]    => [1, 2],
      [[:op, nil, nil],    [nil, @piece, nil],  [nil, nil, :op]]    => [2, 1]
    }
    response_hash[standardize_opponent_grid(game)]
  end

  def standardize_opponent_grid(game)
    game.board.copy_grid.map do |row|
      row.map do |el|
        if el == @piece || el == nil
          el
        else
          :op
        end
      end
    end
  end


  def determine_opponent(game)
    return game.player1 if self == game.player2
    game.player2
  end



end
