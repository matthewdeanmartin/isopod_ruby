# frozen_string_literal: true

# isopod_game.rb

class Game
  attr_reader :inventory, :current_location

  def initialize(input: $stdin, output: $stdout)
    @map = create_map
    @inventory = []
    @current_location = :start
    @input = input
    @output = output
  end

  def play
    @output.puts 'Welcome, Isopod! Your mission is to find a place to hide, a cookie crumb, and another isopod friend.'
    loop do
      display_location
      action = prompt_action
      process_action(action)
      break if win_condition_met?
    end
    @output.puts 'Congratulations, you found all the items and won the game!'
  end

  private

  def create_map
    {
      start: { description: 'You are at the start.', adjacent: %i[forest beach] },
      forest: { description: 'You are in a dense forest.', adjacent: %i[start cave] },
      cave: { description: 'You found a dark cave.', adjacent: [:forest] },
      beach: { description: 'You are on a sandy beach.', adjacent: %i[start rock_pool] },
      rock_pool: { description: 'You see a shallow rock pool.', adjacent: [:beach] }
    }
  end

  def display_location
    @output.puts @map[@current_location][:description]
    @output.puts "You can move to: #{map_adjacent_locations.join(', ')}"
  end

  def map_adjacent_locations
    @map[@current_location][:adjacent]
  end

  def prompt_action
    @output.puts 'What would you like to do? (move/inventory/quit)'
    @input.gets.chomp.downcase
  end

  def process_action(action)
    case action
    when 'move'
      move_to_location
    when 'inventory'
      display_inventory
    when 'quit'
      exit_game
    else
      @output.puts 'Invalid action. Please try again.'
    end
  end

  def move_to_location
    @output.puts "Where would you like to go? (#{map_adjacent_locations.join('/')})"
    destination = @input.gets.chomp.to_sym
    if map_adjacent_locations.include?(destination)
      @current_location = destination
      find_items_at_location
    else
      @output.puts "You can't move there. Please try again."
    end
  end

  def display_inventory
    if @inventory.empty?
      @output.puts 'Your inventory is empty.'
    else
      @output.puts "You have: #{@inventory.join(', ')}"
    end
  end

  def exit_game
    @output.puts 'Thank you for playing. Goodbye!'
    exit
  end

  def win_condition_met?
    @inventory.include?('place to hide') &&
      @inventory.include?('cookie crumb') &&
      @inventory.include?('isopod friend')
  end

  def find_items_at_location
    case @current_location
    when :cave
      find_item('place to hide')
    when :rock_pool
      find_item('cookie crumb')
    when :forest
      find_item('isopod friend')
    else
      @output.puts 'Nothing to find here.'
    end
  end

  def find_item(item)
    if @inventory.include?(item)
      @output.puts "You already found the #{item}."
    else
      @output.puts "You found a #{item}!"
      @inventory << item
    end
  end
end
