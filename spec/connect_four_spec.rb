require './lib/connect_four'

describe Game do
  game = Game.new

  it 'column wins' do
    2.upto(5) do |i|
      game.field[3][i] = 1
    end
    expect(game.column_win).to eq(1)
  end

  it 'row win false' do
    expect(game.row_win).to eq(nil)
  end

  it 'row wins' do
    2.upto(5) do |i|
      game.field[i][2] = 1
    end
    expect(game.row_win).to eq(1)
  end

  it 'diagonal wins' do
    game.new_field
    4.times { |i| game.field[i][i] = 1}
    expect(game.diagonal_win).to eq(1)
  end

  it 'backward diagonal wins' do
    game.new_field
    4.times { |i| game.field[i][5 - i] = 1}
    expect(game.diagonal_win).to eq(1)
  end

  it 'puts a new coin in' do
    game.new_field
    expect(game.put_coin(0, 1)).to eq(1)
  end

  it 'changes player' do
    game.new_field
    expect(game.change_player).to eq(false)
  end

  it 'changes player back' do
    expect(game.change_player).to eq(true)
  end

  it 'changes player back' do
    expect(game.change_player).to eq(false)
  end

  it 'game over' do
    expect(game.game_over).to eq(false)
  end

  it 'game over - no more empty fields' do
    7.times { |i| 6.times { |j| game.field[i][j] = 1} }
    expect(game.game_over).to eq(true)
  end
end
