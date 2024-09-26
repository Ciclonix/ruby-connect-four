# frozen_string_literal: true

require_relative "../lib/connect_four"

describe ConnectFour do
  subject(:game) { described_class.new }

  describe "#addToken" do
    context "when the column is not full" do
      it "returns true" do
        grid = game.instance_variable_get(:@grid)
        grid[0] << :y
        expect(game.addToken(0, :x)).to eq(true)
      end

      it "adds the token to the top of the column" do
        grid = game.instance_variable_get(:@grid)
        grid[0] << :y
        expect { game.addToken(0, :x) }.to change { grid[0] }.from([:y]).to(%i[y x])
      end
    end

    context "when the column is full" do
      before do
        allow(game).to receive(:puts)
      end

      it "returns false" do
        grid = game.instance_variable_get(:@grid)
        grid[0] = %i[a b c d e f]
        expect(game.addToken(0, :x)).to eq(false)
      end
    end

    context "when the column is invalid" do
      before do
        allow(game).to receive(:puts)
      end

      it "returns false" do
        expect(game.addToken(-2, :x)).to eq(false)
      end
    end
  end

  describe "#checkVerticalFour" do
    context "when there is a vertical four" do
      it "returns true" do
        grid = game.instance_variable_get(:@grid)
        grid[6] = %i[b a a a a]
        expect(game.checkVerticalFour).to eq(true)
      end
    end

    context "when there is no vertical four" do
      it "returns false" do
        grid = game.instance_variable_get(:@grid)
        grid[6] = %i[a a a b a]
        expect(game.checkVerticalFour).to eq(false)
      end
    end
  end

  describe "#checkHorizontalFour" do
    context "when there is a horizontal four" do
      it "returns true" do
        grid = game.instance_variable_get(:@grid)
        (1..4).each { |i| grid[i] << :x }
        expect(game.checkHorizontalFour).to eq(true)
      end
    end

    context "when there is no horizontal four" do
      it "returns false" do
        grid = game.instance_variable_get(:@grid)
        (0..2).each { |i| grid[i] << :x }
        grid[4] << :x
        expect(game.checkHorizontalFour).to eq(false)
      end
    end
  end

  describe "#checkDiagonalFour" do
    context "when there is a diagonal four" do
      it "returns true" do
        grid = game.instance_variable_get(:@grid)
        grid[1] = %i[x]
        grid[2] = %i[y x]
        grid[3] = %i[y y x]
        grid[4] = %i[y x x x]
        expect(game.checkDiagonalFour).to eq(true)
      end
    end

    context "when there is no diagonal four" do
      it "returns false" do
        grid = game.instance_variable_get(:@grid)
        grid[1] = %i[x]
        grid[2] = %i[y x]
        grid[3] = %i[x y x]
        grid[4] = %i[x x y y x]
        expect(game.checkDiagonalFour).to eq(false)
      end
    end
  end

  describe "#gridFull?" do
    context "when the grid is full" do
      it "returns true" do
        grid = Array.new(7) { Array.new(6, :x) }
        game.instance_variable_set(:@grid, grid)
        expect(game.gridFull?).to be(true)
      end
    end

    context "when the grid is not full" do
      it "returns false" do
        expect(game.gridFull?).to be(false)
      end
    end
  end

  describe "#play" do
    let(:player1) { {id: "1", symbol: "x"} }
    let(:player2) { {id: "2", symbol: "o"} }

    context "when the first player wins" do
      before do
        allow(game).to receive(:turn)
        allow(game).to receive(:checkWin).and_return(true)
      end

      it "returns the first player" do
        expect(game.play([player1, player2])).to eq(player1)
      end
    end

    context "when the second player wins" do
      before do
        allow(game).to receive(:turn)
        allow(game).to receive(:checkWin).and_return(false, true)
        allow(game).to receive(:gridFull?).and_return(false)
      end

      it "returns the second player" do
        expect(game.play([player1, player2])).to eq(player2)
      end
    end

    context "when the grid is full" do
      before do
        allow(game).to receive(:turn)
        allow(game).to receive(:checkWin).and_return(false)
        allow(game).to receive(:gridFull?).and_return(true)
      end

      it "returns nil" do
        expect(game.play([player1, player2])).to eq(nil)
      end
    end
  end
end
