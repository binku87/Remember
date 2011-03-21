class Stage < ActiveRecord::Base
  belongs_to :next, :class_name => "Stage", :foreign_key => "next_stage_id"
  belongs_to :previous, :class_name => "Stage", :foreign_key => "previous_stage_id"
  after_create :rebuild_stage

  def rebuild_stage
    unless self.previous.nil?
      self.previous.next.update_attribute(:previous, self) unless self.previous.next.nil?
      self.update_attribute(:next, previous.next)
      self.previous.update_attribute(:next, self)
    end
  end

  def things
    Thing.all.select { |thing| thing.stage == self }
  end

  def things_need_to_review
    Thing.all.select { |thing| thing.stage == self && !thing.review? }
  end

  def things
    Thing.all.select { |thing| thing.stage == self }
  end

  def self.first_stage
    where("id = previous_stage_id").first
  end

  def self.last_stage
    where("id = next_stage_id").first
  end

  def self.init_stage
    Stage.first
  end

  def range? interval
    interval >= interval_begin && interval <= interval_end
  end

  def over? interval
    interval_end < interval
  end

  def first_stage?
    self == previous
  end

  def self.all_stages
    stages, current_stage = [], Stage.first_stage
    while
      stages << current_stage
      break if current_stage == Stage.last_stage
      current_stage = current_stage.next
    end
    stages
  end
end
