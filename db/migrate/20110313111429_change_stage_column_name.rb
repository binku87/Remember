class ChangeStageColumnName < ActiveRecord::Migration
  def self.up
    rename_column :stages, :previous_stage, :previous_stage_id
    rename_column :stages, :next_stage, :next_stage_id
  end

  def self.down
  end
end
