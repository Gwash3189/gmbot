require './models/game'
require './models/character'
require './models/spell'
require './models/attack'
require './modules/settings'

DataMapper.setup(:default, "sqlite://#{Dir.pwd}/development.sqlite") unless Settings.production?
DataMapper.setup(:default, "postgres://user:password@hostname/database") unless Settings.development?

DataMapper.auto_upgrade!
DataMapper.finalize
