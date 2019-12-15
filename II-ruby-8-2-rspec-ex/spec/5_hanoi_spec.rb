# frozen_string_literal: true

# Keep three arrays, which represents the piles of discs. Pick a representation of the discs to store in the arrays; maybe just a number representing their size. Don't worry too much about making the user interface pretty.

# In a loop, prompt the user (using gets) and ask what pile to select a disc from, and where to put it.

# After each move, check to see if they have succeeded in moving all the discs, to the final pile. If so, they win!

# Note: don't worry about testing the UI. Testing console I/O is tricky (don't bother checking gets or puts). Focus on:

#     #move
#     #won?

require '5_hanoi'

describe 'Hanoi' do
  subject(:hanoi) { Hanoi.new }

  # describe '#initialize' do
  context 'when initialize' do
    it 'has three towers' do
      expect(hanoi.towers.length).to eq(3)
    end

    it 'has 3 discs on first tower by default' do
      expect(hanoi.towers[0]).to eq((1..3).to_a)
    end

    it 'has 5 discs when given 5 at init' do
      expect(Hanoi.new(5).towers[0]).to eq((1..5).to_a)
    end
  end

  describe '#move' do
    let(:hanoi_moved) do
      hanoi.move([0, 1])
      hanoi
    end

    let(:hanoi_moved_again) do
      hanoi.move([0, 1])
      hanoi.move([0, 2])
      hanoi.move([1, 2])
      hanoi
    end

    context 'when is correct' do
      it 'doesn\'t raise error ' do
        expect { hanoi_moved }.not_to raise_error
      end

      it 'reduces pile from origin' do
        # hanoi_moved.move([0, 1])
        expect(hanoi_moved.towers[0].size).to eq(2)
      end

      it 'add pile to the target' do
        expect(hanoi_moved.towers[1]).to eq([1])
      end
      
      it 'added pile gets on top' do
        expect(hanoi_moved_again.towers[2]).to eq([1, 2])
      end
    end

    context 'when it\'s incorrect' do
      it 'disallows put larger disk onto smaller' do
        # end
        # hanoi.move([0, 1])
        expect { hanoi_moved.move([0, 1]) }.to raise_error InvalidMove
      end
    end
    # No larger disk may be placed on top of a smaller disk.
  end

  describe '#won?' do
    context 'when uncompleted' do
      it 'returns false' do
        expect(hanoi.won?).to be false
      end
    end
    context 'when completed' do
      let(:hanoi_completed) do
        hanoi.move([0, 1])
        # 23 1 0
        hanoi.move([0, 2])
        # 3 1 2
        hanoi.move([1, 2])

        # 3 0 12
        hanoi.move([0, 1])

        # 0 3 12
        hanoi.move([2, 0])

        # 1 3 2
        hanoi.move([2, 1])

        # 1 23 0
        hanoi.move([0, 1])

        # 0 123 0
        hanoi
      end

      it 'returns true' do
        expect(hanoi_completed.won?).to be true
      end
    end
  end
end
