class Stage < ActiveRecord::Base
  def things
    Thing.all.select { |thing| thing.stage == self }
  end

  def self.init_stage
    Stage.first
  end

  def next
    self_id = id
    Stage.all("id > ?", self_id).first
  end
end
