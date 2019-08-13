require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @answer = params[:answer].upcase
    if included?(@answer, params[:grid])
      if english_word?(params[:answer])
        @results = "well done, #{@answer} exists !"
      else
        @results = "Sorry, #{@answer} not an english word."
      end
    else
      @results = "Sorry, #{@answer} is not in the grid."
    end
  end

  def included?(attempt, grid)
    attempt.chars.all? { |letter| attempt.count(letter) <= grid.count(letter) }
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
