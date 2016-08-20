require "rspec"
require "hangman"

describe "Phase III" do
  describe "ComputerPlayer" do
    let(:dictionary) { ["foo", "bar", "foobar"] }
    let(:computer_player) { ComputerPlayer.new(dictionary: dictionary) }
    let(:board) {Board.new(3)}

    describe "#candidate_words" do
      it "returns the list of words not yet eliminated from the dictionary" do
        expect { computer_player.candidate_words }.not_to raise_error
      end
    end

    describe "#update_candidate_words" do
      it "rejects words of the wrong length from #candidate_words" do
        computer_player.set_board(board)
        computer_player.update_candidate_words

        expect(computer_player.candidate_words).to contain_exactly("foo", "bar")
      end
    end

    describe "#handle_response" do
      before(:each) do
        computer_player.set_board(board)
        computer_player.update_candidate_words
      end

      context "when the guessed letter is found at some indices" do
        it "rejects non-matching words from #candidate_words" do
          board.fill_in_letter("o", [1, 2])
          computer_player.update_candidate_words

          expect(computer_player.candidate_words).to eq(["foo"])
        end
      end

      context "when the guessed letter is found at no indices" do
        it "rejects words containing the guessed letter from #candidate_words" do
          board.fill_in_letter("f", [])
          computer_player.update_candidate_words

          expect(computer_player.candidate_words).to eq(["bar"])
        end
      end

      it "correctly handles the response after registering secret length" do
        guesser = ComputerPlayer.new(dictionary: ["leer", "reel", "real", "rear"])
        board = Board.new(4)

        guesser.set_board(board)
        board.fill_in_letter("r", [0])
        guesser.update_candidate_words

        expect(guesser.candidate_words.sort).to eq(["reel","real"].sort)
      end
    end

    describe "#guess" do
      let(:guesser) { ComputerPlayer.new(dictionary: ["reel","keel","meet"]) }
      before(:each) do
        board = Board.new(4)
        guesser.set_board(board)
      end

      context "when no guesses have been made" do
        it "returns the most common letter in #candidate_words" do
          expect(guesser.guess).to eq("E")
        end
      end

      context "when a guess has been made" do
        it "returns the most common letter in the remaining #candidate_words" do
          guesser.board.fill_in_letter("E", [1,2])

          expect(guesser.guess).to eq("L")
        end
      end
    end
  end
end
