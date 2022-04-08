require_relative 'bot'
require_relative 'api_bot'
require 'pry'

RSpec.describe 'first test' do

  api_client = ApiClient.new
  bot = FilmBot.new.run
  context 'verify test is working' do
    create_url('/start')
    expect(message).to eq("Hello, #{message.from.first_name}, choose from list:\n #{HELP_LIST}\n #{ALL_FILMS}")
  end

end