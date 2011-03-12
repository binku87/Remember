require 'test_helper'

class StageTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    stage = Stage.create(:name => "Stage 1", :interval => 1800)
    assert_equal "Stage 1", stage.name
    assert_equal 1800, stage.interval
  end
end
