class AddStageIdForThing < ActiveRecord::Migration
  def self.up
    add_column :things, :stage_id, :integer
  end

  def self.down
  end
end
