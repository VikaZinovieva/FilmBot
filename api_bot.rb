require 'faraday'
require 'json'

# https://api.telegram.org/bot5173660271:AAGbsr3pU1oa08ii6PqLVQ5z2xyviZ_rZuQ/sendMessage?chat_id=204359727&text=Hello%20World
#204359727
#
# {"ok":true,"result":{"message_id":410,"from":{"id":5173660271,"is_bot":true,"first_name":"Film Recomender","username":"Film_Recomender_bot"},
# "chat":{"id":204359727,"first_name":"Vika","type":"private"},"date":1649341793,"text":"Hello World"}}
class ApiClient
  APP_JS = 'application/json'
  TOKEN = '5173660271:AAGbsr3pU1oa08ii6PqLVQ5z2xyviZ_rZuQ'
  CHAT_ID = '204359727'

  def initialize
    @base_url = 'https://api.telegram.org/bot'
  end

  def create_url(message_text)
    # https://api.telegram.org/bot5173660271:AAGbsr3pU1oa08ii6PqLVQ5z2xyviZ_rZuQ/sendMessage?chat_id=204359727&text=Hello%20World
    url = "#{@base_url}bot#{TOKEN}sendMessage?chat_id=#{CHAT_ID}&text=#{message_text}"
    app_request(:post, url)
  end

  private

  def app_request(type, url, body = nil)
    Faraday.send(type, url) do |req|
      req.headers['Content-Type'] = APP_JS
      req.body = body.to_json unless body.nil?
    end
  end
end