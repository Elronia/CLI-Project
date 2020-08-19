class TravelerBucketList
  # here will be your CLI!
  # it is not an AR class so you need to add attr
  # attr_reader :prompt
  attr_accessor :traveler, :prompt


  def initialize
    @prompt = TTY::Prompt.new
  end

  def run
    welcome
    welcome_menu
    main_menu
    # quotes, colors, fonts
  end

  # create_a_user: -create an account,
  # -go to main menu
  # log_in: -main_menu
  

  def welcome
    puts "Hello, Traveler!"
  end

  def welcome_menu
    @prompt.select ("Welcome to your Bucket List App. What would you like to do?") do |menu|
        menu.choice "See All Wishes", -> { display_wishes }
        menu.choice "See All Destinations", -> { display_destinations }
        menu.choice "Log In", -> { log_in }
        menu.choice "Create a User", -> { Traveler.create_new_traveler() }
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

  def log_in
    system "clear"
    username_input = @prompt.ask("Enter Username: ")
    username_age = @prompt.ask("Enter Age: ")

    @@traveler_found = Traveler.find_by(traveler_name: username_input, traveler_age: username_age)


    if !@@traveler_found
      puts "\nSorry, invalid username and/or age"
      @prompt.select(" ", cycle: true) do |menu|
        menu.choice "Try Again", -> {log_in} 
        menu.choice "Go Back", -> {welcome_menu} 
      end
    else
      puts "\nLog In Successful!\n"
      print "\nTaking you to Main Menu"
      # sleep(0.2)
      main_menu
    end

  end

  # def user_helper
  #   travelerReturnValue = Traveler.register()
  #       until travelerReturnValue
  #           travelerReturnValue = Traveler.register
  #       end
  #       self.traveler = travelerReturnValue
  #       self.main_menu
  #   end


  # main_menu:

    def main_menu
      system "clear"
        puts "Where are we going?"
        answers = @prompt.select("SELECT AN OPTION:\n ", "View my bucket list", "Create a new bucket list") 
          if answers == "View my bucket list"
            puts "Hello"
          else 
            create_a_bucket_list
          end
        #     menu.choiсe "View my bucket list", -> { puts "Hello" }
        #     menu.choice "Create a new bucket list", -> { create_a_bucket_list }
        # end
    end

  # -my_bucket_list (here we need to play around with our BucketListItem):
  # 1. view_or_add (which is view the list and add smth new)
  # 2.mark_completed
  # 3. remove_my_bucket_list (or we can have here "remove_wish/destination")
  # -create_a_new_bucket_list (add_wishes_destinations) 

    # def my_bucket_list
    #   view_my_current_list
    #   add_wishes_destinations
    #   mark_completed #from false to true
    #   remove_my_bucket_list
    # end

    def create_a_wish
      wish = Wish.create(destination_id)
    end

    def create_a_bucket_list
      BucketListItem.create(traveler_id: @@traveler_found.id, wish_id: Wish.)
      puts "Saved to your Bucket List"
      sleep(0.3)
    end

    

    # def mark_completed

    # end

  private
  
end
