class Character
  include DataMapper::Resource

  property :name, String, :key => true
  property :hp, Integer, :required => true
  property :ailments, Text, :required => false
  property :level, Integer, :required => false

  belongs_to :game
end
