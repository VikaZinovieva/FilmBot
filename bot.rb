require 'telegram/bot'
require_relative 'FilmListAnalyzer'
require 'pry'

class FilmBot
  TOKEN = '5173660271:AAGbsr3pU1oa08ii6PqLVQ5z2xyviZ_rZuQ'
  ALL_FILMS = "List of all films: /all type of film"
  HELP_LIST = "/detectives🕵️‍️\n /comedy😂\n /horror 👻\n /romantic ❤️\n /animation 🎠"
  STOP = 'Have a nice watching!'
  WRONG = "I don't understand you! 🤷"
  TYPES = %w[detectives comedy horror animation romantic]

  def run
    bot.listen do |message|
      answer_message(message)
    rescue => e
      puts e.message
    end
  end

  private

  def send_message(chat_id, message)
    bot.api.sendMessage(chat_id: chat_id, text: message)
  end

  def bot
    Telegram::Bot::Client.run(TOKEN) { |bot| return bot }
  end

  def answer_message(message)
    type = message.text
    case type
    when '/start'
      send_message(message.chat.id, "Hello, #{message.from.first_name}, choose from list:\n #{HELP_LIST}\n #{ALL_FILMS}")
    when (type if type.include?('/all'))
      receive_type = message.text.split.last
      message_text = TYPES.include?(receive_type) ? FilmListAnalyzer.new.format_list_films(receive_type) : WRONG
      send_message(message.chat.id, message_text)
    when (type if TYPES.include?(type.delete '/'))
      send_message(message.chat.id, FilmListAnalyzer.new.random_film(type.delete '/'))
    else
      send_message(message.chat.id, WRONG)
    end
  end

end
