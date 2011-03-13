require 'test_helper'

class StageTest < ActiveSupport::TestCase
  test "get next stage and previous stage" do
    current_stage = Stage.first_stage
    assert_equal "Stage 1", current_stage.name
    current_stage = current_stage.next
    assert_equal "Stage 2", current_stage.name
    current_stage = current_stage.next
    assert_equal "Stage 3", current_stage.name
    current_stage = current_stage.next
    assert_equal "Stage 3", current_stage.name

    current_stage = current_stage.previous
    assert_equal "Stage 2", current_stage.name
    current_stage = current_stage.previous
    assert_equal "Stage 1", current_stage.name
    current_stage = current_stage.previous
    assert_equal "Stage 1", current_stage.name
  end
end
