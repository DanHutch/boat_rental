## dock.rb

require 'pry'
require './lib/boat'
require './lib/rental'

class Dock < Boat

  attr_reader :name,
              :max_rental_time,
              :revenue,
              :rented_boats

  def initialize(name, max_rental_time)
    @name = name
    @max_rental_time = max_rental_time
    @revenue = 0
    @rented_boats = []
  end

  def rent(boat, renter)
    @rented_boats << boat
    boat.rented = true
    boat.renter = renter
  end

  def log_hour
    @rented_boats.each do |boat|
      if boat.hours_rented < max_rental_time
        boat.add_hour
      end
    end
  end

  def return(boat)
    boat.rented = false
  end

  def revenue
    @rented_boats.map do |boat|
      boat.hours_rented * boat.price_per_hour
    end.sum
  end

  # def charges
  #   charge_list = {}
  #   @rented_boats.each do |boat|
  #     charge_list[boat.renter.credit_card_num] = boat.hours_rented * boat.price_per_hour
  #   end
  # end

end
