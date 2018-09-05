## dock_test.rb

require 'minitest/autorun'
require 'minitest/pride'
require './lib/dock'
require './lib/renter'
require './lib/boat'
require "./lib/rental"
require 'pry'

class DockTest < Minitest::Test

  def test_it_exists
    dock = Dock.new("The Rowing Dock", 3)
    assert_instance_of(Dock, dock)
  end

  def test_it_has_a_name
    dock = Dock.new("The Rowing Dock", 3)
    assert_equal("The Rowing Dock", dock.name)
  end

  def test_it_has_max_rental_time
    dock = Dock.new("The Rowing Dock", 3)
    assert_equal(3, dock.max_rental_time)
  end

  def test_revenue_starts_at_zero
    dock = Dock.new("The Rowing Dock", 3)
    assert_equal(0, dock.revenue)
  end

  def test_rent_makes_boat_rented
    dock = Dock.new("The Rowing Dock", 3)
    kayak_1 = Boat.new(:kayak, 20)
    patrick = Renter.new("Patrick Star", "4242424242424242")
    refute(kayak_1.rented)
    dock.rent(kayak_1, patrick)
    assert(kayak_1.rented)
    assert_equal(1, dock.rented_boats.count)
  end

  def test_return_makes_boat_not_rented
    dock = Dock.new("The Rowing Dock", 3)
    kayak_1 = Boat.new(:kayak, 20)
    patrick = Renter.new("Patrick Star", "4242424242424242")
    refute(kayak_1.rented)
    dock.rent(kayak_1, patrick)
    assert(kayak_1.rented)
    assert_equal(1, dock.rented_boats.count)
    dock.return(kayak_1)
    refute(kayak_1.rented)
  end

  def test_log_hour_counts_if_rented
    dock = Dock.new("The Rowing Dock", 3)
    kayak_1 = Boat.new(:kayak, 20)
    patrick = Renter.new("Patrick Star", "4242424242424242")
    dock.rent(kayak_1, patrick)
    dock.log_hour
    assert_equal(1, kayak_1.hours_rented)
  end

  def test_log_hour_stops_at_max
    dock = Dock.new("The Rowing Dock", 3)
    kayak_1 = Boat.new(:kayak, 20)
    patrick = Renter.new("Patrick Star", "4242424242424242")
    dock.rent(kayak_1, patrick)
    dock.log_hour
    dock.log_hour
    dock.log_hour
    dock.log_hour
    assert_equal(3, kayak_1.hours_rented)
  end


  def test_it_tracks_revenue_properly
    dock = Dock.new("The Rowing Dock", 3)
    kayak_1 = Boat.new(:kayak, 20)
    kayak_2 = Boat.new(:kayak, 20)
    canoe = Boat.new(:canoe, 25)
    sup_1 = Boat.new(:standup_paddle_board, 15)
    sup_2 = Boat.new(:standup_paddle_board, 15)
    patrick = Renter.new("Patrick Star", "4242424242424242")
    eugene = Renter.new("Eugene Crabs", "1313131313131313")
    dock.rent(kayak_1, patrick)
    dock.rent(kayak_2, patrick)
    dock.log_hour
    dock.rent(canoe, patrick)
    dock.log_hour
    dock.return(kayak_1)
    dock.return(kayak_2)
    dock.return(canoe)
    assert_equal(105, dock.revenue)
    dock.rent(sup_1, eugene)
    dock.rent(sup_2, eugene)
    dock.log_hour
    dock.log_hour
    dock.log_hour
    assert_equal(195, dock.revenue)
  end

  # def test_it_tracks_renter_bills
  #   dock = Dock.new("The Rowing Dock", 3)
  #   kayak_1 = Boat.new(:kayak, 20)
  #   kayak_2 = Boat.new(:kayak, 20)
  #   canoe = Boat.new(:canoe, 25)
  #   sup_1 = Boat.new(:standup_paddle_board, 15)
  #   sup_2 = Boat.new(:standup_paddle_board, 15)
  #   patrick = Renter.new("Patrick Star", "4242424242424242")
  #   eugene = Renter.new("Eugene Crabs", "1313131313131313")
  #   dock.rent(kayak_1, patrick)
  #   dock.rent(kayak_2, patrick)
  #   dock.log_hour
  #   dock.rent(canoe, patrick)
  #   dock.log_hour
  #   dock.return(kayak_1)
  #   dock.return(kayak_2)
  #   dock.return(canoe)
  #   dock.rent(sup_1, eugene)
  #   dock.rent(sup_2, eugene)
  #   dock.log_hour
  #   dock.log_hour
  #   dock.log_hour
  #   dock.log_hour
  #   dock.log_hour
  #   dock.return(sup_1)
  #   dock.return(sup_2)
  #   expected = {"4242424242424242" => 105, "1313131313131313" => 90}
  #   assert_equal(expected, dock.charges)
  # end

end
