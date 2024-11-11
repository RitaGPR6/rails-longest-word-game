require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @letters = params[:letters].split
    @word_input = params[:word].upcase
    @english = english_word(@word_input)
    @on_the_grid = on_the_grid(@word_input, @letters)
  end

  def english_word(word_input)
    word_input_serialized = URI.open("https://dictionary.lewagon.com/#{word_input}")
    word_input = JSON.parse(word_input_serialized.read)
    word_input['found']
  end

  def on_the_grid(word_input, letters)
    word_input.chars.all? do |letter|
      word_input.count(letter) <= letters.count(letter)
    end
  end
end
