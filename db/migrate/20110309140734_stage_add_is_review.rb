class StageAddIsReview < ActiveRecord::Migration
  def self.up
    add_column :things, :is_review, :boolean, :default => false
  end

  def self.down
    remove_column :things, :is_review
  end
end
