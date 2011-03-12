class ChangeStageStruct < ActiveRecord::Migration
  def self.up
    remove_column :stages, :interval
    add_column :stages, :interval_begin, :integer
    add_column :stages, :interval_end, :integer
  end

  def self.down
  end
end
