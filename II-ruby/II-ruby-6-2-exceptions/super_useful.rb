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
  def message
    "I can't have any more caffeine. My poor heart couldn't take it. You can try again."
  end
end

class NotFruitError < StandardError
  def message
    "That doesn't look like a fruit. You tricked me. * runs away *"
  end
end

def reaction(maybe_fruit)
  if FRUITS.include? maybe_fruit
    puts "OMG, thanks so much for the #{maybe_fruit}!"
  elsif maybe_fruit == "coffee"
    raise CoffeeError
  else
    raise NotFruitError
  end
end

def feed_me_a_fruit
  puts "Hello, I am a friendly monster. :)"

  begin
    puts "Feed me a fruit! (Enter the name of a fruit:)"
    maybe_fruit = gets.chomp
    reaction(maybe_fruit)
  rescue CoffeeError => e
    puts e.message
    retry
  rescue NotFruitError => e
    puts e.message
  end
end

# PHASE 4
class BestFriend
  class NoBestFriendDetailError < StandardError
  end

  class TooShortRelationError < StandardError
  end

  def initialize(name, yrs_known, fav_pastime)
    raise ArgumentError, "'name' cannot be blank" if name.empty?
    raise ArgumentError.new("'yrs_known' must be greater than or equal to 5 (best friendships take time)") if yrs_known.to_i < 5
    raise ArgumentError.new("'fav_pasttime' cannot be blank") if fav_pastime.empty?

    @fav_pastime = fav_pastime
    @name = name
    @yrs_known = yrs_known.to_i
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
