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
  end

  describe "#checkVerticalFour" do
    context "when there are four vertical identical connected tokens" do
      it "returns true" do
        grid = game.instance_variable_get(:@grid)
        grid[6] = %i[b a a a a]
        expect(game.checkVerticalFour).to eq(true)
      end
    end

    context "when there are no four vertical identical connected tokens" do
      it "returns false" do
        grid = game.instance_variable_get(:@grid)
        grid[6] = %i[a a a b a]
        expect(game.checkVerticalFour).to eq(false)
      end
    end
  end

  describe "#checkHorizontalFour" do
    context "when there are four horizontal identical connected tokens" do
      it "returns true" do
        grid = game.instance_variable_get(:@grid)
        (1..4).each { |i| grid[i] << :x }
        expect(game.checkHorizontalFour).to eq(true)
      end
    end

    context "when there are no four horizontal identical connected tokens" do
      it "returns false" do
        grid = game.instance_variable_get(:@grid)
        (0..2).each { |i| grid[i] << :x }
        grid[4] << :x
        expect(game.checkHorizontalFour).to eq(false)
      end
    end
  end

  describe "#checkDiagonalFour" do
    context "when there are four diagonal identical connected tokens" do
      it "returns true" do
        grid = game.instance_variable_get(:@grid)
        grid[1] = %i[x]
        grid[2] = %i[y x]
        grid[3] = %i[y y x]
        grid[4] = %i[y x x x]
        expect(game.checkDiagonalFour).to eq(true)
      end
    end

    context "when there are no four diagonal identical connected tokens" do
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
end
