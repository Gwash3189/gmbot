require './modules/roller'
require "byebug"

RSpec.describe Roller do
  valid_roll = '1d6'
  invalid_roll = 'xdy'
  valid_multi_roll = '100d600'
  invalid_multi_roll = 'xxxdyyy'

  describe '#parse_dice_text' do
    context 'with valid input' do
      context 'with a single digit roll' do
        it 'returns the roll, total of rolls needed and the required dice' do
          expect(Roller.parse_dice_text(valid_roll)).to eq([1, 6])
        end
      end

      context 'with a multi digit roll' do
        it 'returns the roll, total of rolls needed and the required dice' do
          expect(Roller.parse_dice_text(valid_multi_roll)).to eq([100, 600])
        end
      end
    end

    context 'with invalid input' do
      it 'returns an empty array' do
        expect(Roller.parse_dice_text(invalid_roll)).to eq(false)
      end
    end
  end

  describe '#roll_dice' do
    context 'with valid input' do
      it 'returns the sum of the requested dice rolls' do
        expect(Roller.roll_dice(1, 6)).to be <= 6
      end
    end
  end

  describe '#roll' do
    context 'with valid input' do
      it 'returns a string describing the new result' do
        expect(Roller.roll(valid_roll)).to be_a(Fixnum)
      end
    end
  end
end
