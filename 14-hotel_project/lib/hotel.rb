require_relative "room"

class Hotel
  def initialize(name, rooms)
    @name = name
    @rooms = {}
    rooms.each { |k, v| @rooms[k] = Room.new(v) }
  end

  def name
    @name.split(" ").map(&:capitalize).join(" ")
  end

  def rooms
    @rooms
  end

  def room_exists?(room_name)
    rooms.has_key?(room_name)
  end

  def check_in(person, room_name)
    unless room_exists?(room_name)
      p "sorry, room does not exist"
      return false
    end

    unless rooms[room_name].add_occupant(person)
      p "sorry, room is full"
      return false
    end

    p "check in successful"
  end

  def has_vacancy?
    if rooms.values.all?(&:full?)
      false
    else
      true
    end
  end

  def list_rooms
    rooms.each_key { |k| puts "#{k} #{rooms[k].available_space}" }
  end
end
