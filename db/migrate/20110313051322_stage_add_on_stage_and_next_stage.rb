class StageAddOnStageAndNextStage < ActiveRecord::Migration
  def self.up
    add_column :stages, :previous_stage, :integer
    add_column :stages, :next_stage, :integer
  end

  def self.down
    remove_column :stages, :previous_stage
    remove_column :stages, :next_stage
  end

end
