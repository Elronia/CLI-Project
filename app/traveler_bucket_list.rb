class TravelerBucketList
  # here will be your CLI!
  # it is not an AR class so you need to add attr
  attr_reader :prompt
  attr_accessor :traveler

  def initialize
    @prompt = TTY::Prompt.new
  end

  def welcome
    puts "Hello, Traveler!"
  end

  def welcome_menu
    prompt.select ("Welcome to our Application. What would you like to do?") do |menu|
        menu.choice "See All Wishes", -> { display_wishes }
        menu.choice "See All Destinations", -> { display_destinations }
        # menu.choice "Log In", -> { log_in }
        menu.choice "Create a User", -> { user_register_helper }
    end
  end
  
  def display_wishes
    Wish.all.map do |wish|
      puts wish.wish_note
    end
  end

  def display_destinations
    Destination.all.map do |destination|
      puts destination.destination_name
    end
  end

  def user_register_helper
    travelerReturnValue = Traveler.register()
        until travelerReturnValue
            travelerReturnValue = Traveler.register
        end
      self.traveler = travelerReturnValue
      self.main_menu
  end

  def main_menu
    binding.pry
    traveler.reload #makes sure that we get the most up to date info
    system "clear" #pushes this to the top of the terminal
    puts "Welcome, #{self.traveler.traveler_name}"
      prompt.select("Choose something to do") do |menu|
          menu.choiсe "See my wishes", -> { puts "My wish" }
          menu.choiсe "See my destinations", -> { puts "My destination" }
      end
  end

  def run
    welcome
    welcome_menu
    # login_or_signup
    # wanna_see_favs?
    # get_joke(what_subject)
  end

  private
  
end
