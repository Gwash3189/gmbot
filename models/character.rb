class Character
  include DataMapper::Resource

  property :id, Serial, :key => true
  property :name, String, :required => true
  property :hp, Integer, :required => true
  property :ailments, Text, :required => false
  property :level, Integer, :required => false

  belongs_to :game
end
