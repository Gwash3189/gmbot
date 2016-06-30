require './modules/personel'
require "byebug"

RSpec.describe Personel do
  valid_input = "name: steve, hp: 60, level: 7"
  valid_output = { :name => 'steve', :hp => '60', :level => '7' }

  describe "#parse_personel_data" do
    it 'returns a map of the data' do
      expect(Personel.parse_personel_data(valid_input)).to eq(valid_output)
    end
  end
end
