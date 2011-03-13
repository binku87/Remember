namespace :remember do
  desc "Creat first stage and last stage"
  task :create_basic_stages => :environment do
    a_day = 86400
    first_stage = Stage.create(:name => "First Stage", :previous => nil, :next => nil, :interval_begin => 0, :interval_end => 0)
    last_stage = Stage.create(:name => "Last Stage", :previous => first_stage, :next => nil, :interval_begin => a_day * 15, :interval_end => a_day * 16)
    first_stage.update_attributes(:previous => first_stage, :next => last_stage)
    last_stage.update_attributes(:previous => first_stage, :next => last_stage)
  end
end
