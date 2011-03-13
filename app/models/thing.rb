class Thing < ActiveRecord::Base
  belongs_to :stage
  after_create :set_stage
  

  def set_stage
    update_attribute(:stage, Stage.init_stage)
  end

  def stage_with_update
    if !review? && stage_without_update.next.range(updated_at)
      update
    else
      stage_without_update
    end
  end

  alias_method_chain :stage, :update
  
  def review!
    update_attribute(:is_review, true)
    go_to_next_stage
  end

  def review?
    is_review  
  end

  def go_to_next_stage
    update_attribute(:stage, stage.next)
  end
  
  def return_to_previous_stage
    update_attribute(:stage, stage.previous)
  end
end
