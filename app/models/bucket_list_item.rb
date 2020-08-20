class BucketListItem < ActiveRecord::Base
  belongs_to :traveler
  belongs_to :wish

  def self.all_bucket_list_items
    BucketListItem.all.map do |item|
      { item.wish_completed => item.wish_id } 
    end
  end

end
# wish_completed: false, traveler_id: 3, wish_id: 3

