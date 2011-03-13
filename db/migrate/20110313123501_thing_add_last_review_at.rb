class ThingAddLastReviewAt < ActiveRecord::Migration
  def self.up
    add_column :things, :last_review_at, :datetime
  end

  def self.down
  end
end
