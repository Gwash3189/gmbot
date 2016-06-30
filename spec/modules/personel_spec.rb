require './modules/personel'
require "byebug"

RSpec.describe Personel do


  describe "#parse_attrs" do
    valid_input = "name: steve, hp: 60, level: 7"
    valid_output = { :name => 'steve', :hp => '60', :level => '7' }

    it 'returns a map of the data' do
      expect(Personel.parse_attrs(valid_input)).to eq(valid_output)
    end
  end

  describe "#parse_update_attrs" do
    valid_input = "steve, hp: 60, level: 7"
    valid_output = { :name => 'steve', :hp => '60', :level => '7' }

    it 'returns a tuple of the name and attr' do
      expect(Personel.parse_update_data(valid_input)).to eq(valid_output)
    end
  end
end
