class Wish < ActiveRecord::Base

  belongs_to :destination
  has_many :bucket_list_items
  has_many :travelers, through: :bucket_list_items
  
  def self.all_wishes
    Wish.all.map do |wish|
      { wish.wish_note => wish.id } 
    end
  end

  def self.find_by_name(wish_note)
    Wish.all.find do |wish|
      wish.wish_note == wish_note
      wish
    end
  end

end
