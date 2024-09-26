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
        grid[0] = %i[b a a a a]
        expect(game.checkVerticalFour).to eq(true)
      end
    end

    context "when there are no four vertical identical connected tokens" do
      it "returns false" do
        grid = game.instance_variable_get(:@grid)
        grid[0] = %i[a a a b a]
        expect(game.checkVerticalFour).to eq(false)
      end
    end
  end
end
