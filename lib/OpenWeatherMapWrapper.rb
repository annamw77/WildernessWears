require 'httparty'

class OpenWeatherMapWrapper
  attr_reader :id, :desc, :temp, :image, :city

  BASE_URL = "http://api.openweathermap.org/data/2.5/"

  def initialize(data)
    @id = data["weather"][0]["id"]
    @desc = data["weather"][0]["description"]
    @temp = data["main"]["temp"]
    @image = "http://openweathermap.org/img/w/#{data["weather"][0]["icon"]}.png"
    @city = data["name"]
  end

  def self.find(zipcode)
    data = HTTParty.get(BASE_URL + "weather?zip=#{zipcode},us&units=imperial&APPID=#{ENV["OPEN_WEATHER_MAP_KEY"]}").parsed_response
    self.new(data)
  end

end
