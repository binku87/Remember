class Thing < ActiveRecord::Base
  def stage
    pre_stage = Stage.where(:name => "Stage 1").first
    Stage.order("interval DESC").all.each do |stage|
      if (created_at <= Time.now - stage.interval) && (created_at >= Time.now - pre_stage.interval)
        return is_review ? stage : pre_stage
      end
      pre_stage = stage
    end
  end

  def need_review?
  end
end
