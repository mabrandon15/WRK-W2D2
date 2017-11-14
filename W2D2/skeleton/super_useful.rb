# PHASE 2
def convert_to_int(str)
    Integer(str)
  rescue ArgumentError
    nil
end
# PHASE 3
FRUITS = ["apple", "banana", "orange"]

def reaction(maybe_fruit)
  if FRUITS.include? maybe_fruit
    puts "OMG, thanks so much for the #{maybe_fruit}!"
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
  rescue StandardError
    puts "That's not a fruit, but I like coffee!"
    retry if maybe_fruit.downcase == "coffee"
  end
end

# PHASE 4
class BestFriend
  def initialize(name, yrs_known, fav_pastime)
    @name = name
    raise ArgumentError.new('Invalid name') if name.length.zero?
    raise ArgumentError.new("Can't be best friends if known for < 5 years") if yrs_known < 5
    @yrs_known = yrs_known
    @fav_pastime = fav_pastime
    raise ArgumentError.new('Invalid pastime') if fav_pastime.length.zero?
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
