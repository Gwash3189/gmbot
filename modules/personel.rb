module Personel
  def self.parse_personel_data(str)
    personel_data = {}

    str.split(',').map do |pair|
      prop, value = pair.split(':')
      personel_data[prop.strip.to_sym] = value.strip
    end

    personel_data
  end

  def self.add(str_attr, game)
    personel_data = parse_personel_data(str_attr)
    personel_data['game'] = game

    char = Character.new(personel_data)
    if char.save
      char.name
    else
      false
    end
  end
end
