require 'dotenv/load'
require 'discordrb'

bot = Discordrb::Bot.new token: ENV.fetch('DISCORDRB_TOKEN')

bot.message do |event|
  p event.content
  if event.content == '!poison'
    event.message.embeds.each do |embed|
      bot.voice_connect(embed.title)
      bot.voice(event.server).play_file(embed.url)
    end
    event.message.delete
    bot.voice(event.server).destroy
  end
end

bot.run
