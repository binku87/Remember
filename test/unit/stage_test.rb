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

  test "auto set next stage and set next stage' previous point ot self when create" do
    second_stage = Stage.first_stage.next
    stage = Stage.create(:name => "Stage between stage 2 and stage 3", :previous => second_stage)
    assert_equal stage, second_stage.next
    assert_equal Stage.last_stage, stage.next
    assert_equal stage, Stage.last_stage.previous
  end
end
