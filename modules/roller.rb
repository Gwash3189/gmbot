module Roller

  def self.not_valid_roll?(roll)
    split = roll.split('d')
    times, dice = split

    split.length < 2 || (times.to_i === 0 && dice.to_i === 0)
  end

  def self.parse_dice_text(text)
    if not_valid_roll?(text)
      return false
    end

    result = text.split('d')

    if !result
      return []
    end

    times, dice = result

    [times.to_i, dice.to_i]
  end

  def self.roll_dice(times, dice)
    result = 0

    (1..times).each do
      result = rand(1..(dice - 1)) + result
    end

    result
  end

  def self.roll(text)
    times, dice = parse_dice_text(text)
    roll_dice(times, dice)
  end
end
