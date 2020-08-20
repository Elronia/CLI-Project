require 'pry'
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
#****************************************** Welcome *******************************************************
  def welcome
    puts "Hello, Traveler!"
  end

  def welcome_menu
    @prompt.select ("Welcome to your Bucket List App. What would you like to do?") do |menu|
        menu.choice "Log In", -> { log_in }
        menu.choice "Create a User", -> { Traveler.create_new_traveler() }
    end
  end

  def display_and_add_wishes
    chosen_wish = prompt.select("Please choose your wish", Wish.all_wishes)
    binding.pry
    # wish = Wish.create(wish_note: wish.wish_note, destination_id: destination.id)
    bucket_list = BucketListItem.create(wish_completed: false, traveler_id: @@traveler_found.id, wish_id: chosen_wish)
    puts "Saved to your Bucket List"
    sleep(2)
  end

  def complete_a_wish
    # chosen_bucket_list_item = prompt.select("Please select one wish to complete", BucketListItem.all_bucket_list_items)
    chosen_wish = prompt.select("Please choose your wish", Wish.all_wishes)
    BucketListItem.find_by(wish_id: chosen_wish)
    bucket_list = BucketListItem.update(wish_completed: true, traveler_id: @@traveler_found.id, wish_id: chosen_wish)
    puts "Your wish is complete"
  end

  #create a new option in a main menu "Complete a wish"
  #invoke a helper method "Complete a wish"
  #inside of this helper method show the user all the bucket list
  #select one to complete (bucket_list_items)
  #selected bucket_list update method on it and changing completed to true

  #destroy the instance

  def create_another_wish_helper
    @prompt.select ("Would you like to add another wish?") do |menu|
      menu.choice "Yes", -> { display_and_add_wishes }
      menu.choice "No", -> { main_menu }
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

  #***************************************Main_menu:*********************************

  # menu.choice "See All Wishes", -> { display_and_add_wishes }
  # menu.choice "See All Destinations", -> { display_destinations }
    def main_menu
      system "clear"
        puts "Where are we going?"
        answers = @prompt.select("SELECT AN OPTION:\n ", "View my bucket list", "Create a new bucket list","See All Wishes", "See All Destinations", "Complete a wish") 
          if answers == "View my bucket list"
            puts "Hello"
          elsif answers == "Create new bucket list"
            puts "See your bucket list"
          elsif answers == "See All Wishes"
            display_and_add_wishes
          elsif answers == "See All Destinations"
            puts "See your destinations"
          elsif answers == "Complete a wish"
            complete_a_wish
          else 
            bucket_list
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

    
    # def display_traveler_bucket_list_items
    #   # self.user <- Person who is logged in
    #   # self.user.plants <- All of the plants associated with the User
    #   # self.user.plant_parenthoods <- All of the PlantParenthood instances 
    #   self.traveler.bucket_list_items.each do |item|
    #       puts uph.traveler.name
    #       puts uph.affection
    #       puts "*******"
    #   end

    #    sleep 5
    #    self.main_menu
    #   # self.main_menu <- To take me back to the main_menu
    # end

    # def mark_completed

    # end

  # private
  
end
