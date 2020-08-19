class Traveler < ActiveRecord::Base
    has_many :bucket_list_items
    has_many :wishes, through: :bucket_list_items

    def self.create_new_traveler
    travelerInfo = TTY::Prompt.new.ask("What is your username?")
    ageInfo = TTY::Prompt.new.ask("What is your age?")
    if Traveler.find_by(traveler_name: travelerInfo, traveler_age: ageInfo) 
        puts "Sorry, it looks like that username is taken."
    else
        Traveler.create(traveler_name: travelerInfo, traveler_age: ageInfo.to_i)
        end
      end
  end

    # def self.create_new_traveler
    #   travelerInfo = TTY::Prompt.new.ask("What is your username?")
    #   ageInfo = TTY::Prompt.new.ask("What is your age?")
    #   traveler = Traveler.create(traveler_name: travelerInfo, traveler_age: ageInfo)

    #   if Traveler.find_by(name: travelerInfo) 
    #     puts "Sorry, it looks like that username is taken."
    # else
    #     Traveler.create(name: travelerInfo, age: ageInfo.to_i)
    # end
#     end
# end
