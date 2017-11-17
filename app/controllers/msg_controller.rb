class MsgController < ApplicationController
  def new
  end

  def send_msg
    # require 'rest-client'
    # require 'json'
    # require 'awesome_print'
    # require 'nokogiri'

    @msg = params[:msg]
    # 1. get token
    token = ENV["token"]

    # 2. get user id
    uri = "https://api.telegram.org/"
    user_response = RestClient.get(uri + "bot#{token}/getUpdates")
    json_response = JSON.parse(user_response)
    chat_id = json_response["result"][0]["message"]["chat"]["id"]
    # 3. 메세지 보내기
    msg = @msg
    url = uri + "bot#{token}/sendmessage?chat_id=#{chat_id}&text=#{msg}"
    RestClient.get(URI.encode(url))

    redirect_to :back
  end

end
