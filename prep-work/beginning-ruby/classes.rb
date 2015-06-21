class Square
  
  def self.class_method
    puts "Hello from sqaure class!"
  end
  
  def self.count
    puts defined?(@@number) ? @@number : 0
  end
  
  def initialize(side_length)
    @side_length = side_length
    @@number = defined?(@@number) ? @@number + 1 : 1
  end
  
  def area
    @side_length * @side_length
  end
  
end

class Person
  
  def initialize(name)
    set_name(name)
  end
  
  def name
    @first_name + " " + @last_name
  end
  
  private
  
    def set_name(name)
      name = name.split(/\s+/)
      set_firstname(name[0])
      set_lastname(name[1])
    end
    
    def set_firstname(name)
      @first_name = name
    end
    
    def set_lastname(name)
      @last_name = name
    end
    
end

class Doctor < Person
  
  def name
    "Dr. " + super
  end
  
end



class Dungeon
  attr_accessor :player
  
  def initialize(player_name)
    @player = Player.new(player_name)
    @rooms = []
  end
  
  def add_room(reference, name, description, connections)
    @rooms << Room.new(reference, name, description, connections)
  end
  
  def start(location)
    @player.location = location
    show_current_description
    navigate
  end
  
  def prompt_user
    puts "Where would you like to go?"
    connections = find_room_in_dungeon(@player.location).connections
    connections.each_with_index do |dir, i|
      puts "#{i + 1}: #{dir[0].to_s}"
    end
    puts "#{connections.length + 1}: exit_dungeon"
    gets.chomp.to_sym
  end
  
  def navigate
    exit_game = false
    while !exit_game
      dir = prompt_user
      (dir == :exit_dungeon) ? (exit_game = true) : (self.go(dir))
    end  
  end
  
  def show_current_description
    puts find_room_in_dungeon(@player.location).full_description
  end
  
  def find_room_in_dungeon(reference)
    @rooms.detect { |r| r.reference == reference }
  end
  
  def find_room_in_direction(direction)
    find_room_in_dungeon(@player.location).connections[direction]
  end
  
  def go(direction)
    puts "You go " + direction.to_s
    @player.location = find_room_in_direction(direction)
    show_current_description
  end
  
  class Player
    attr_accessor :name, :location
    
    def initialize(name)
      @name = name
    end
  end
  
  class Room
    attr_accessor :reference, :name, :description, :connections
    
    def initialize(reference, name, description, connections)
      @reference = reference
      @name = name
      @description = description
      @connections = connections
    end
    
    def full_description
      @name + "\n\nYou are in " + @description
    end
  end
end

class String
  def titleize
    self.gsub(/(\A|\s)\w/) { |char| char.upcase }
  end
end
    

