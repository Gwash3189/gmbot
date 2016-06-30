module Personel
  def self.parse_attrs(x)
    personel_data = {}
    data = x

    if x.is_a?(String)
      data = x.split(',')
    end

    data.map do |pair|
      prop, value = pair.split(':')
      personel_data[prop.strip.to_sym] = value.strip
    end

    personel_data
  end

  def self.parse_update_data(str)
    attrs = str.split(',')
    name = attrs.first
    attrs.shift
    attrs.unshift("name: #{name}")
    return parse_attrs(attrs)
  end

  def self.update(str, game)
    attrs = parse_update_data(str)
      .merge(:game => game)

    char = Character.first(:name => attrs[:name])

    if char.update(attrs)
      char.name
    else
      false
    end
  end

  def self.add(str_attr, game)
    personel_data = parse_attrs(str_attr)
    personel_data = personel_data.merge(:game => game)

    char = Character.new(personel_data)

    if char.save
      char.name
    else
      false
    end
  end
end
