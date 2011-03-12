class Thing < ActiveRecord::Base
  belongs_to :stage
  after_create :set_stage

  def set_stage
    update_attribute(:stage, Stage.init_stage)
  end

  #def stage
    # pre_stage = Stage.where(:name => "Stage 1").first
    # Stage.order("interval DESC").all.each do |stage|
    #   if (created_at <= Time.now - stage.interval) && (created_at >= Time.now - pre_stage.interval)
    #     return is_review ? stage : pre_stage
    #   end
    #   pre_stage = stage
    # end
  #end

  def review!
    update_attribute(:is_review, true)
  end

  def go_to_next_stage
    update_attribute(:stage, stage.next)
  end
end
