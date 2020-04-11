require 'open-uri'
class GamesController < ApplicationController
  VOWELS = %w(A E I O U Y)

  def new
    # generate 10 letters
    vowels = VOWELS.sample(5)
    consonants = (('A'..'Z').to_a - vowels).sample(5)
    @letters = (vowels + consonants).shuffle

    # ('A'..'Z').to_a.sample(10)
  end

  def score
    # raise
    # get the letter
    @word = params[:word].upcase
    letters = params[:letters].split
    # validate if the words is part of the letter
    @valid_word = valid_word?(@word, letters)
    # validate that the word is an English word
    @english_word = english_word?(@word)
  end

  private

  def valid_word?(word, letters)
    # short: word.chars.all?{|letter| word.count(letter) <= letters.count(letter)}
    valid = true
    word.chars.each do |letter|
      if word.count(letter) > letters.count(letter)
        valid = false
      end
      return valid
    end
  end

  def english_word?(word)
    request = open("https://wagon-dictionary.herokuapp.com/#{word}")
    response = JSON.parse(request.read)
    response['found']
    # valid = false
  end
end
