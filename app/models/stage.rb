class Stage < ActiveRecord::Base
  belongs_to :next, :class_name => "Stage", :foreign_key => "next_stage"
  belongs_to :previous, :class_name => "Stage", :foreign_key => "previous_stage"
  def things
    Thing.all.select { |thing| thing.stage == self }
  end

  def self.first_stage
    where("id = previous_stage").first
  end

  def self.last_stage
    where("id = next_stage").first
  end

  def self.init_stage
    Stage.first
  end

  def range time
    if !first_stage? && name == "Stage 2"
       Time.now - updated_at > 2.days
    end
  end

  def first_stage?
    previous_stage == -1
  end
end
