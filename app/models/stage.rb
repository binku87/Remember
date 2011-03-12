class Stage < ActiveRecord::Base
  def things
    Thing.all.select { |thing| thing.stage == self }
  end
end
