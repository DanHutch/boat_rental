## renter.rb

require 'pry'

class Renter
  attr_reader :name,
              :credit_card_num

  def initialize(name, credit_card_num)
    @name = name
    @credit_card_num = credit_card_num
  end

end
