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
    # random_quote
    # sleep(5)
    welcome
    welcome_menu
    main_menu
    # quotes, colors, fonts
  end

#***************************************Welcome**************************************
  
  def welcome
    puts "Hello, Traveler!"
  end

  def welcome_menu
    @prompt.select ("Welcome to your Bucket List App. What would you like to do?") do |menu|
        menu.choice "Log In", -> { log_in }
        menu.choice "Create a User", -> { self.traveler = Traveler.create_new_traveler() }
    end
  end

  def view_my_bucket_list
    self.traveler.bucket_list_items
  end

  def display_and_add_wishes
    chosen_wish = prompt.select("Please choose your wish", Wish.all_wishes)
    bucket_list = BucketListItem.create(wish_completed: false, traveler_id: self.traveler.id, wish_id: chosen_wish)
    puts "Saved to your Bucket List"
    main_menu
    sleep(2)
  end

  # def create_a_new_bucket_list
  #   prompt.select("Which wish would you like?") do |menu|
  #     Wish.all.each do |wish|
  #       menu.choice "#{wish.wish_note}"
  #     end
  #   end
  # prompt.ask
  # end
  
  # #   h.wish_note
  #   sec_var = new_wish.destination_id
  #   find_dest = Destination.find(sec_var).destination_name
  #   puts "Hnew_var = BucketListItem.all.last.id
  #   new_wish = Wish.find(new_var)
  #   sec = new_wisello #{self.traveler.traveler_name}. You have created this wish #{sec} and add this destination #{find_dest}"
  #   # binding.pry
  #   sleep(5)
  #   main_menu
  # end

  # def complete_a_wish
  #   # chosen_bucket_list_item = prompt.select("Please select one wish to complete", BucketListItem.all_bucket_list_items)
  #   chosen_wish = prompt.select("Please choose your wish", Wish.all_wishes)
  #   bucket_list_find = BucketListItem.find_by(wish_id: chosen_wish)
  #   # binding.pry
  #   bucket_list_find.update(wish_completed: true)
  #   puts "Your wish is complete"
  # end

  def bucket_list
    # BucketListItem.create(wish_completed: false, traveler_id: @@traveler_found.id, wish_id: chosen_wish)
    puts "Hello! This is bucket list"
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

  # def display_wishes
  #   Wish.all.map do |wish|
  #     puts wish.wish_note
  #   end
  # end

  def display_destinations
    Destination.all.map do |destination|
      puts destination.destination_name
    end
    sleep(3)
    main_menu
  end

  def log_in
    system "clear"
    username_input = @prompt.ask("Enter Username: ")
    username_age = @prompt.ask("Enter Age: ")

    self.traveler = Traveler.find_by(traveler_name: username_input, traveler_age: username_age)

      if !self.traveler
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

  # def random_quote # puts a random inspirational quote
  #   response = RestClient.get("https://type.fit/api/quotes")
  #   quotes = JSON.parse(response)
  #   random_quote_hash = quotes.sample
  #   random_quote_text = random_quote_hash["text"]
  #   random_quote_author = random_quote_hash["author"]
  #   random_quote_author = "Unknown" if random_quote_author == nil
  #   puts "\"#{random_quote_text}\""
  #   puts "- #{random_quote_author}"
  # end

  # def user_helper
  #   travelerReturnValue = Traveler.register()
  #       until travelerReturnValue
  #           travelerReturnValue = Traveler.register
  #       end
  #       self.traveler = travelerReturnValue
  #       self.main_menu
  #   end

  #***************************************Main_menu:*********************************

    def main_menu
      system "clear"
        puts "Where are we going?"
        answers = @prompt.select("SELECT AN OPTION:\n ", "View my bucket list", "See All Wishes", "See All Destinations") #, "Complete a wish") 
          if answers == "View my bucket list"
            view_my_bucket_list
          # elsif answers == "Create a new bucket list"
          #   create_a_new_bucket_list
          elsif answers == "See All Wishes"
            display_and_add_wishes
          elsif answers == "See All Destinations"
            display_destinations
          elsif answers == "Complete a wish"
            complete_a_wish
          else 
            bucket_list
          end
    end

    # def my_bucket_list
    #   view_my_current_list
    #   add_wishes_destinations
    #   mark_completed #from false to true
    #   remove_my_bucket_list
    # end

  # private
  
end
