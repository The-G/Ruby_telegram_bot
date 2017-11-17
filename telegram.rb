require 'rest-client'
require 'json'
require 'awesome_print'
require 'nokogiri'

def get_kospi
  uri = "http://finance.naver.com/sise/"
  response = RestClient.get(uri)
  # return response # optional

  text = Nokogiri::HTML(response)
  kospi = text.css('#KOSPI_now').text # select로
  kospi
end
def get_kosdaq
  uri = "http://finance.naver.com/sise/sise_index.nhn?code=KOSDAQ"
  response = RestClient.get(uri)
  text = Nokogiri::HTML(response)
  kosdaq = text.css('#now_value').text # select로
  kosdaq
end

# 1. get token
token = ENV["token"]

# 2. get user id
uri = "https://api.telegram.org/"
# me = RestClient.get(uri + "bot#{token}/getMe")
# talk = RestClient.get(uri + "bot#{token}/getUpdates")
user_response = RestClient.get(uri + "bot#{token}/getUpdates")
# p user_response
json_response = JSON.parse(user_response)
# ap json_response

chat_id = json_response["result"][0]["message"]["chat"]["id"]

# ap chat_id


# 3. 메세지 보내기
msg = "오늘의 kospi 지수는 #{get_kospi} 입니다. kosdaq은 #{get_kosdaq} 입니다."
url = uri + "bot#{token}/sendmessage?chat_id=#{chat_id}&text=#{msg}"
RestClient.get(URI.encode(url))

# send msg each 10 seconds
# while true
#     sleep(10)
#     RestClient.get(URI.encode(url))
# end
