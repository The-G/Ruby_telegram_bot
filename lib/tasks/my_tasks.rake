namespace :crawling do

  def get_kospi
    uri = "http://finance.naver.com/sise/"
    response = RestClient.get(uri)
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

  task :kospi do
    # require 'rest-client'
    # require 'json'
    # require 'awesome_print'
    # require 'nokogiri'
    token = ENV["token"]
    uri = "https://api.telegram.org/"
    user_response = RestClient.get(uri + "bot#{token}/getUpdates")
    json_response = JSON.parse(user_response)
    chat_id = json_response["result"][0]["message"]["chat"]["id"]
    msg = "오늘의 kospi 지수는 " + get_kospi + "입니다."
    url = uri + "bot#{token}/sendmessage?chat_id=#{chat_id}&text=#{msg}"
    RestClient.get(URI.encode(url))
  end

  task :kosdaq do
    # require 'rest-client'
    # require 'json'
    # require 'awesome_print'
    # require 'nokogiri'
    token = ENV["token"]
    uri = "https://api.telegram.org/"
    user_response = RestClient.get(uri + "bot#{token}/getUpdates")
    json_response = JSON.parse(user_response)
    chat_id = json_response["result"][0]["message"]["chat"]["id"]
    msg = "오늘의 kosdaq 지수는 " + get_kosdaq + "입니다."
    url = uri + "bot#{token}/sendmessage?chat_id=#{chat_id}&text=#{msg}"
    RestClient.get(URI.encode(url))
  end

end
