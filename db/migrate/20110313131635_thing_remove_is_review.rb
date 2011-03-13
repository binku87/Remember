class ThingRemoveIsReview < ActiveRecord::Migration
  def self.up
    remove_column :things, :is_review
  end

  def self.down
  end
end
