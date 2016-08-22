require "rspec"
require "ship"
require "helper"
require "position"
require "board"
require "byebug"

describe Board do
  subject(:board) { Board.new }

  let(:empty_grid) { Array.new(2) { Array.new(2) } }
  single_ship = Ship.new("Small One", 1)
  let(:empty_board) { Board.new(empty_grid, [single_ship]) }

  ship1 = Ship.new("Small One", 1)
  ship2 = Ship.new("Small Two", 1)

  let(:two_ship_grid) { [[nil, nil], [nil, nil]] }
  let(:two_ship_board) { Board.new(two_ship_grid, [ship1,ship2]) }

  let(:full_grid) { [[:s, :s], [:s, :s]] }
  let(:full_board) { Board.new(full_grid) }

  describe "::default_grid" do
    let(:grid) { Board.default_grid }

    it "returns a 10x10 grid" do
      expect(grid.length).to eq(10)

      grid.each do |row|
        expect(row.length).to eq(10)
      end
    end
  end

  describe "#initialize" do
    context "when passed a grid" do
      it "initializes with the provided grid" do
        expect(empty_board.grid).to eq(empty_grid)
      end
    end

    context "when not passed a grid" do
      it "initializes with Board::default_grid" do
        grid = Board.default_grid

        expect(Board).to receive(:default_grid).and_call_original

        expect(board.grid).to eq(grid)
      end
    end
  end

  describe "#count" do
    it "returns the number of ships on the board" do
      expect(empty_board.count).to eq(0)
      ship1.place( Position.new(0,0, two_ship_board), Position.new(0,0, two_ship_board) )
      ship2.place( Position.new(0,1, two_ship_board), Position.new(0,1, two_ship_board) )

      expect(two_ship_board.count).to eq(2)
    end
  end

  describe "#has_ship?" do
    context "when passed a position" do
      it "returns false for an empty position" do
        ship1.place( Position.new(0,0, two_ship_board), Position.new(0,0, two_ship_board) )
        ship2.place( Position.new(0,1, two_ship_board), Position.new(0,1, two_ship_board) )
        expect(two_ship_board.has_ship?([1, 1])).to be_falsey
      end

      it "returns true for an occupied position" do
        ship1.place( Position.new(0,0, two_ship_board), Position.new(0,0, two_ship_board) )
        ship2.place( Position.new(0,1, two_ship_board), Position.new(0,1, two_ship_board) )
        expect(two_ship_board.has_ship?([0, 0])).to be_truthy
      end
    end

    context "when not passed a position" do
      context "with ships on the board" do
        it "returns false" do
          ship1.place( Position.new(0,0, two_ship_board), Position.new(0,0, two_ship_board) )
          ship2.place( Position.new(0,1, two_ship_board), Position.new(0,1, two_ship_board) )
          expect(two_ship_board).not_to be_empty
        end
      end

      context "with no ships on the board" do
        it "returns true" do
          expect(empty_board).to be_empty
        end
      end
    end
  end

  describe "#full?" do
    context "when the board is full" do
      it "returns true" do
        expect(full_board).to be_full
      end
    end

    context "when the board is not full" do
      it "returns false" do
        expect(two_ship_board).not_to be_full
      end
    end
  end

  describe "#randomly_place" do
    context "when the board is full" do
      it "raises an error" do
        expect { ship1.randomly_place(full_board) }.to raise_error
      end
    end

    context "when the board is empty" do
      it "places a ship in a random position" do
        single_ship.randomly_place(empty_board)

        expect(empty_board.count).to eq(1)
      end

      it "places ships until the board is full" do
        expect do
          empty_board.randomly_place_ships until empty_board.full? || empty_board.all_ships_placed?
        end.not_to raise_error
      end
    end
  end

  describe "#won?" do
    context "when no ships remain" do
      it "returns true" do
        single_ship.hits << [0,0]
        expect(empty_board).to be_won
      end
    end

    context "when at least one ship remains" do
      it "returns false" do
        expect(two_ship_board).not_to be_won
      end
    end
  end
end
