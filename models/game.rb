class Game
  include DataMapper::Resource

  property :id, String, :key => true

  has n, :characters
  has n, :attacks
  has n, :spells
end
