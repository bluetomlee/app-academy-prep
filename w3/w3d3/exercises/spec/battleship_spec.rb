require "rspec"
require "battleship"
require "board"
require "player"

describe BattleshipGame do
  let(:player_one) { ComputerPlayer.new("johnny") }
  let(:player_two) { ComputerPlayer.new("alfred") }

  let(:game) { BattleshipGame.new(player_one, player_two) }

  describe "#initialize" do
    it "accepts a player one and player two as arguments" do
      expect { game }.not_to raise_error
    end
  end

  describe "#attack" do
    it "marks the board at the specified position" do
      game.players[0].board.attack(Position.new(1, 1, game.players[0].board))
      expect(game.players[0].board[1, 1]).to eq("-")
    end
  end

  describe "#swap_players" do
    it "changes the current player" do
      game.swap_players
      expect(game.turn).to eq(1)
    end
  end

  describe "#game_over?" do
    it "delegates to the board's #won? method" do
      expect(game.players[0].board).to receive(:won?)

      game.game_over?
    end
  end

  describe "#play_turn" do
    it "gets a move from the player and makes an attack at that position" do
      game.set_attacking_boards

      expect(game.players[1].board).to receive(:attack)
      expect(game.players[1].board).to receive(:display)

      game.players[0].take_turn
    end
  end
end
