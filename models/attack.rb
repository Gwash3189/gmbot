class Attack
  include Roller
  include DataMapper::Resource

  property :id, Serial, :key => true
  property :name, String, :required => true
  property :dice, String, :required => true

  belongs_to :game
end
