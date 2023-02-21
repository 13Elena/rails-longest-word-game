require "json"
require "open-uri"
class GamesController < ApplicationController

  def new
  # The new action will be used to display a new random grid and a form.
    array = ('a'..'z').to_a
    @letters = array.sample(10).join
    return @letters
  end

  def score
    # The form will be submitted (with POST) to the score action.
    @word = params[:word]
    @letters = params[:letters].split

      url = "https://wagon-dictionary.herokuapp.com/#{@word}"

      user_serialized = URI.open(url).read
      hash = JSON.parse(user_serialized)


      if hash["found"] == true && @letters.include?(@word.split(", "))
        @result = "CONGRATULATIONS !"
      elsif @letters.include?(@word.split(", "))
        @result = "Sorry but #{@word} can't be build out of #{@letters}"
      else
        @result = "Sorry but #{@word} does not seem to be a valid English word..."
      end
  end
end
