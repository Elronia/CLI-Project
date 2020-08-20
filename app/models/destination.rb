class Destination < ActiveRecord::Base
    has_many :wishes
    has_many :bucket_list_items, through: :wishes

    def self.all_destinations
        Destination.all.map do |destination|
          { destination.destination_name => destination.id }
        end
    end
    
end
