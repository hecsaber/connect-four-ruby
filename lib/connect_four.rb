class Game
  attr_accessor :field, :players, :active_player

  def initialize
    @field = Array.new(7) { Array.new(6) }
    @players = []
    @active_player = true
  end

  def add_players(player1, player2)
    players << player1
    players << player2
  end

  def change_player
    if @active_player
      @active_player = false
    else
      @active_player = true
    end
    @active_player
  end

  def new_field
    self.initialize
  end

  def column_win
    result = nil
    field.each do |col|
      3.times do |i|
        result = col[i] if col[i] == col[i + 1] && \
          col[i + 1] == col[i + 3] && col[i + 2] == col[i + 3] \
          && !col[i].nil?
      end
    end
    result
  end

  def row_win
    result = nil
    4.times do |i|
      6.times do |j|
        result = field[i][j] if field[i][j] == field[i + 1][j] && field[i + 2][j] == \
          field[i][j] && field[i + 3][j] == field[i][j] && !field[i][j].nil?
      end
    end
    result
  end

  def diagonal_win
    result = nil
    4.times do |i|
      3.times do |j|
        result = field[i][j] if field[i][j] == field[i + 1][j + 1] && \
          field[i][j] == field[i + 2][j + 2] && field[i][j] \
          == field[i + 3][j + 3] && !field[i][j].nil?

        result = field[i][5 - j] if field[i][5 - j] == field[i + 1][5 - j - 1] && \
          field[i][5 - j] == field[i + 2][5 - j - 2] && \
          field[i][5 - j] == field[i + 3][5 - j - 3] && !field[i][5 - j].nil?
      end
    end
    result
  end

  def game_over
    result = true
    @field.each do |val|
      result = false if val.include? nil
    end
    result
  end

  def go_next_round
    result = true
    result = false if !diagonal_win.eql?(nil) || !column_win.eql?(nil) || !row_win.eql?(nil) || game_over
    result
  end

  def put_coin(position, player)
    field[position].each_with_index do |v, i|
      return field[position][i] = player if v.nil?
    end
  end

  def show_columns
    res = ''
    game = @field
    6.times do |i|
      res += '|'
      7.times do |j|
        if game[j][5 - i].nil?
          res += ' '
        else
          res += game[j][5 - i]
        end
        res += '|'
      end
      res += "\n"
    end
    res
  end
end

class Player
  attr_reader :name, :sign, :points

  def initialize(name, sign, points = 0)
    @name = name
    @sign = sign
    @points = points
  end
end
puts 'Specify player one\'s name'
first = gets.chomp
puts 'Specify player two\'s name'
second = gets.chomp
player1 = Player.new(first, 'O')
player2 = Player.new(second, 'X')
game = Game.new
game.players << player1
game.players << player2

while game.go_next_round
  if game.active_player
    player = game.players[0]
  else
    player = game.players[1]
  end
  puts "#{player.name}'s turn\nPlease choose a column from 0-6"
  position = -1
  position = gets.to_i until position >= 0 && position < 7
  game.put_coin(position, player.sign)
  game.change_player
  puts game.show_columns
end
game.field.each { |i| p i}
puts "The winner is: #{game.active_player ? game.players[1].name : game.players[0].name}"
