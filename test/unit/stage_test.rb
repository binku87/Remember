require 'test_helper'

class StageTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    #stage = Stage.create(:name => "Stage 1", :interval => 1800)
    #assert_equal "Stage 1", stage.name
    #assert_equal 1800, stage.interval
  end

  test "get next stage" do
    current_stage = Stage.first_stage
    assert_equal "Stage 1", current_stage.name
    current_stage = current_stage.next
    assert_equal "Stage 2", current_stage.name
    current_stage = current_stage.next
    assert_equal "Stage 3", current_stage.name
  end
end
