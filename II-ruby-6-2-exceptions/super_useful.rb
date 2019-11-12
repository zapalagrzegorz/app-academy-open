# PHASE 2
def convert_to_int(str)
  begin
    Integer(str)
  rescue ArgumentError
    return nil
  end
end

# PHASE 3
FRUITS = ["apple", "banana", "orange"]

class CoffeeError < StandardError
end

def reaction(maybe_fruit)
  if FRUITS.include? maybe_fruit
    puts "OMG, thanks so much for the #{maybe_fruit}!"
  elsif maybe_fruit == "coffee"
    raise CoffeeError
  else
    raise StandardError
  end
end

def feed_me_a_fruit
  puts "Hello, I am a friendly monster. :)"

  begin
    puts "Feed me a fruit! (Enter the name of a fruit:)"
    maybe_fruit = gets.chomp
    reaction(maybe_fruit)
  rescue CoffeeError
    puts "Try again. Thanks for coffee."
    retry
  end
end

# PHASE 4
class BestFriend
  class Error < RuntimeError
  end

  class NoBestFriendDetailError < Error
  end

  class TooShortRelationError < Error
  end

  def initialize(name, yrs_known, fav_pastime)
    if name.empty? || fav_pastime.empty?
      raise NoBestFriendDetailError, "Name || fav_pastime is empty"
    else
      @fav_pastime = fav_pastime
      @name = name
    end

    if yrs_known >= 5
      @yrs_known = yrs_known
    else
      raise TooShortRelationError, "At least 5 years is needed"
    end
  end

  def talk_about_friendship
    puts "Wowza, we've been friends for #{@yrs_known}. Let's be friends for another #{1000 * @yrs_known}."
  end

  def do_friendstuff
    puts "Hey bestie, let's go #{@fav_pastime}. Wait, why don't you choose. 😄"
  end

  def give_friendship_bracelet
    puts "Hey bestie, I made you a friendship bracelet. It says my name, #{@name}, so you never forget me."
  end
end
