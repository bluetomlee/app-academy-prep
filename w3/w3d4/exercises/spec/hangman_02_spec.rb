require "rspec"
require "hangman"

describe "Phase II" do
  describe "ComputerPlayer" do
    let(:player) { ComputerPlayer.new(dictionary: ["foobar"]) }
    let(:board)  { Board.new(6) }

    describe "#set_board" do
      it "accepts a board as an argument" do
        expect { player.set_board(board) }.not_to raise_error
      end
    end

    describe "#guess" do
      before(:each) { player.set_board(board) }

      it "accepts a board" do
        expect { player.guess }.not_to raise_error
      end

      it "returns a letter" do
        letter = player.guess

        expect(letter).to be_instance_of(String)
        expect(letter.length).to eq(1)
      end
    end
  end
end
