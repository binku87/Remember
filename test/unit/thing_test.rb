require 'test_helper'

class ThingTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  def setup
    # 12h == 43200s
    # first stage  : 0
    # second stage : 12 hours ~ 18 hours
    # third stage  : 24 hours ~ 36 hours
    @a_day = 86400
    Stage.destroy_all
    @init_time = Time.now
    Timecop.freeze(@init_time)
    @stage1 = Stage.create(:name => "Stage 1", :previous => nil, :next => nil, :interval_begin => 0, :interval_end => 0)
    @stage2 = Stage.create(:name => "Stage 2", :previous => @stage1, :next => nil, :interval_begin => @a_day / 2, :interval_end => @a_day * 0.75)
    @stage1.update_attribute(:next, @stage2)
    @stage3 = Stage.create(:name => "Stage 3", :previous => @stage2, :next => nil, :interval_begin => @a_day, :interval_end => 2 * @a_day)
    @stage2.update_attribute(:next, @stage3)
    @stage3.update_attribute(:next, @stage3)
    @thing = Thing.create(:name => "A", :content => "contentA")
  end

  test "create a new thing and it's stage should be 'Stage 1'" do
    assert_equal @stage1, @thing.stage
  end

  test "between 12 hours and one day, it's stage should still be 'Stage 1'" do
    Timecop.freeze(@init_time + 12.hours)
    assert_equal @stage1, @thing.stage
  end

  test "between 12 hours and one day, i marked it as reviewed, it should go to 'Stage 2'" do
    Timecop.freeze(@init_time + 12.hours)
    @thing.review!
    assert_equal @stage2, @thing.stage
  end

  test "when go to new stage period, it should change review to false" do
    Timecop.freeze(@init_time + 5.hours)
    assert_equal true, @thing.review?

    Timecop.freeze(@init_time + 12.hours)
    assert_equal false, @thing.review?
    @thing.review!
    assert_equal true, @thing.review?

    Timecop.freeze(@init_time + 19.hours)
    assert_equal true, @thing.review?

    Timecop.freeze(@init_time + @a_day)
    assert_equal false, @thing.review?
  end

  test "it in 'Stage 2' and after 2 days later and it still didn't be reviewed, it should go to 'Stage 1'" do
    Timecop.freeze(@init_time + 12.hours)
    @thing.review!
    assert_equal @stage2, @thing.stage

    Timecop.freeze(@init_time + @a_day * 2 - 1)
    assert_equal @stage2, @thing.stage

    Timecop.freeze(@init_time + @a_day * 2 + 1)
    assert_equal @stage1, @thing.stage
  end

  test "it in 'Stage 2' and before 2 days later and it is reviewed, it should go to 'Stage 3'" do
    Timecop.freeze(Time.now + 12.hours)
    @thing.review!
    assert_equal @stage2, @thing.stage

    Timecop.freeze(Time.now + @a_day*2 - 1)
    @thing.review!
    assert_equal @stage3, @thing.stage
  end
end
