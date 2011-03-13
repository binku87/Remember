class Thing < ActiveRecord::Base
  belongs_to :stage
  after_create :set_stage, :set_last_review_at

  def set_stage
    update_attribute(:stage, Stage.init_stage)
  end

  def set_last_review_at
    update_attribute(:last_review_at, Time.now)
  end

  def stage_with_update
    if !review? && stage_without_update.next.over?(Time.now - created_at)
      update_attribute(:stage, stage_without_update.previous)
      stage_without_update
    else
      stage_without_update
    end
  end

  alias_method_chain :stage, :update

  def review!
    update_attributes(:last_review_at => Time.now, :stage => stage_without_update.next)
  end

  def review?
    if stage_without_update.next.interval_begin <= Time.now - created_at
      (last_review_at - created_at) >= stage_without_update.next.interval_begin
    else
      (last_review_at - created_at) >= stage_without_update.interval_begin
    end
  end

  def return_to_previous_stage
    update_attribute(:stage, stage.previous)
  end
end
