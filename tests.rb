# frozen_string_literal: true

# test_isopod_game.rb

require 'minitest/autorun'
require_relative 'isopod_game'

class GameTest < Minitest::Test
  def setup
    @input = StringIO.new
    @output = StringIO.new
    @game = Game.new(input: @input, output: @output)
  end

  def test_initial_location
    assert_equal :start, @game.current_location, "Player should start at the 'start' location."
  end

  def test_initial_inventory
    assert_empty @game.inventory, 'Inventory should be empty at the start of the game.'
  end

  def test_move_to_adjacent_location
    @game.instance_variable_set(:@current_location, :start)
    set_input('forest')
    @game.send(:move_to_location)
    assert_equal :forest, @game.current_location, 'Player should move to the forest location.'
  end

  def test_move_to_non_adjacent_location
    @game.instance_variable_set(:@current_location, :start)
    set_input('cave')
    @game.send(:move_to_location)
    assert_equal :start, @game.current_location,
                 'Player should remain at the start location when trying to move to a non-adjacent location.'
  end

  def test_find_place_to_hide
    @game.instance_variable_set(:@current_location, :cave)
    @game.send(:find_items_at_location)
    assert_includes @game.inventory, 'place to hide',
                    "Inventory should include 'place to hide' after visiting the cave."
  end

  def test_find_cookie_crumb
    @game.instance_variable_set(:@current_location, :rock_pool)
    @game.send(:find_items_at_location)
    assert_includes @game.inventory, 'cookie crumb',
                    "Inventory should include 'cookie crumb' after visiting the rock pool."
  end

  def test_find_isopod_friend
    @game.instance_variable_set(:@current_location, :forest)
    @game.send(:find_items_at_location)
    assert_includes @game.inventory, 'isopod friend',
                    "Inventory should include 'isopod friend' after visiting the forest."
  end

  def test_win_condition_not_met
    @game.instance_variable_set(:@inventory, ['place to hide', 'cookie crumb'])
    refute @game.send(:win_condition_met?), 'Win condition should not be met if not all items are found.'
  end

  def test_win_condition_met
    @game.instance_variable_set(:@inventory, ['place to hide', 'cookie crumb', 'isopod friend'])
    assert @game.send(:win_condition_met?), 'Win condition should be met if all items are found.'
  end

  def test_inventory_display
    @game.instance_variable_set(:@inventory, ['place to hide', 'cookie crumb'])
    @game.send(:display_inventory)
    assert_includes @output.string, 'You have: place to hide, cookie crumb'
  end

  def test_no_inventory_display
    @game.send(:display_inventory)
    assert_includes @output.string, 'Your inventory is empty.'
  end

  private

  def set_input(*inputs)
    @input.string = "#{inputs.join("\n")}\n"
    @input.rewind
  end
end
