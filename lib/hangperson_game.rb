class HangpersonGame
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word
    @guesses = ""
    @wrong_guesses = ""
  end
  
  def isletter?(lookAhead)
    lookAhead =~ /[A-Za-z]/
  end
  
  def guess(letter)
    # if letter.nil? or letter.length == 0 or (not isletter?(letter))
    #   raise ArgumentError
    # end
    letter = letter.downcase
    redundant = false
    if @guesses.include? letter or @wrong_guesses.include? letter
      redundant = true
    end
    if (not @word.include? letter) and (not @wrong_guesses.include? letter)
      @wrong_guesses += letter
    elsif not @guesses.include? letter
      @guesses += letter
    end
    if redundant
      return false
    end
    return true
  end
  
  def word_with_guesses
    str = ""
    for i in 0...@word.length
      if @guesses.include? word[i]
        str += word[i]
      else
        str += "-"
      end
    end
    return str
  end
  
  def check_win_or_lose
    if @word.chars.sort.join.squeeze == @guesses.chars.sort.join.squeeze
    # if @word.chars.sort.join == @guesses.chars.sort.join
      return :win 
    end
    if @wrong_guesses.length >= 7
      return :lose
    end
    return :play
  end
  
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
