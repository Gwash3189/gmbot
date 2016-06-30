require 'slack-ruby-bot'
require './modules/roller'
require './modules/personel'

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
    "#{data.channel}-#{data.team}"
  end

  command 'roll' do |client, data, match|
    result = Roller.roll(match.captures.last)

    if result.length === 0
      client.say(text: "something went wrong :(", channel: data.channel)
    else
      client.say(text: "the result of #{match.captures.last} was *#{result}*", channel: data.channel)
    end
  end

  command 'hi' do |client, data, match|
    game = Game
      .first_or_create({id: id(data)})
    if game.save
      client.say(text: "Hello! I've gone ahead and started a game for this channel. To get help on what to do next, just ask for it.", channel: data.channel)
    else
      client.say(text: "Something went wrong with creating your game.", channel: data.channel)
    end
  end

  command 'add character' do |client, data, match|
    byebug
    char_name = Personel.add(match.captures.last, Game.first(id(data)))
    if char_name
      client.say(text: "#{char_name} was added.", channel: data.channel)
    else
      client.say(text: "Something went wrong :(", channel: data.channel)
    end
  end
end
