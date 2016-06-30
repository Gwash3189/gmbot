require 'slack-ruby-bot'
require './modules/roller'
require './modules/personel'
require './modules/settings'

class GmBot < SlackRubyBot::Bot
  # help do
  #   title "Gm Bot"
  #   desc "Helps you manage play by post games."
  #
  #   command 'roll <xdy>' do
  #     desc 'rolls some dice for you and reports the result.'
  #     long_desc 'command example: roll 1d20'
  #   end
  #
  #   command 'hi' do
  #     desc 'starts recording metrics, and allows you to start creating *attacks*, *spells* and *characters*'
  #     long_desc 'command format: hi'
  #   end
  #
  #   command 'add character <name>, <hp> HP' do
  #     desc 'adds a character and tracks their stats'
  #     long_desc 'command example: add character steve, 65hp'
  #   end
  #
  #   command 'report character <name>' do
  #     desc 'reports the current stats of <name>'
  #     long_desc 'command example: report character steve'
  #   end
  # end

  def self.id(data)
    { :id => "#{data.channel}-#{data.team}" }
  end

  def self.last(match)
    match.captures.last
  end

  if Settings.development?
    command 'debug' do |client, data, match|
      byebug
    end
  end

  command 'roll' do |client, data, match|
    result = Roller.roll(match.captures.last)

    if result == 0
      client.say(text: "something went wrong :(", channel: data.channel)
    else
      client.say(text: "the result of #{match.captures.last} was *#{result}*", channel: data.channel)
    end
  end

  command 'hi' do |client, data, match|
    game = Game
      .first_or_create(id(data))

    if game.save
      client.say(text: "Hello! I've gone ahead and started a game for this channel. To get help on what to do next, just ask for it.", channel: data.channel)
    else
      client.say(text: "Something went wrong with creating your game.", channel: data.channel)
    end
  end

  command 'add character' do |client, data, match|
    char_name = Personel
      .add(last(match), Game.first(id(data)))

    if char_name
      client.say(text: "#{char_name} was added.", channel: data.channel)
    else
      client.say(text: "Something went wrong :(", channel: data.channel)
    end
  end

  command 'update character' do |client, data, match|
    char_name = Personel
      .update(last(match), Game.first(id(data)))

    if char_name
      client.say(text: "#{char_name} was updated.", channel: data.channel)
    else
      client.say(text: "Something went wrong :(", channel: data.channel)
    end
  end

  command 'report character' do |client, data, match|
    char = Character.first(:name => last(match))

    if char
      client.say(text: char.to_json, channel: data.channel)
    else
      client.say(text: "I couldn't find a character by that name.", channel: data.channel)
    end
  end
end
