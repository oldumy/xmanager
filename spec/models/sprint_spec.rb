require 'spec_helper'

describe Sprint do
  describe 'validation' do
    before(:each) do
      @sprint = Sprint.new
    end

    it 'should have a release' do
      @sprint.should have(1).error_on(:release)
    end

    it 'should have a name within 1..100 characters' do
      @sprint.should have(2).errors_on(:name)

      @sprint.name = 'a'
      @sprint.should have(:no).error_on(:name)

      @sprint.name = 'a' * 100
      @sprint.should have(:no).error_on(:name)

      @sprint.name = 'a' * 101
      @sprint.should have(1).error_on(:name)
    end

    it 'should have a esitmated started date' do
      @sprint.should have(1).error_on(:estimated_started_on)
    end

    it 'should have a estimated closed date' do
      @sprint.should have(2).error_on(:estimated_closed_on)
    end

    it 'should be closed after started' do
      @sprint.estimated_started_on = DateTime.now.to_date
      @sprint.estimated_closed_on = 1.day.ago.to_date
      @sprint.should have(1).error_on(:estimated_closed_on)
    end
  end

  describe 'start/close' do
    before(:each) do
      @sprint = Factory(:sprint_1)
    end

    it 'should be started' do
      @sprint.sprint_backlogs.should_receive(:exists?).and_return(true)
      @sprint.start.should be_true
      @sprint.started?.should be_true
      @sprint.on_air?.should be_true
    end

    it 'is not closable if not started' do
      @sprint.should_receive(:started?).and_return(false)
      @sprint.closable?.should be_false
    end

    it 'is not closable if no sprint backlog' do
      @sprint.should_receive(:started?).and_return(true)
      @sprint.sprint_backlogs.should_receive(:exists?).and_return(false)
      @sprint.closable?.should be_false
    end

    it 'is not closable if a product backlog is open' do
      @sprint.should_receive(:started?).and_return(true)
      @sprint.sprint_backlogs.should_receive(:exists?).and_return(true)
      @sprint.product_backlogs.unclosed.should_receive(:exists?).and_return(true)
      @sprint.closable?.should be_false
    end

    it 'is closable' do
      @sprint.should_receive(:started?).and_return(true)
      @sprint.sprint_backlogs.should_receive(:exists?).and_return(true)
      @sprint.product_backlogs.unclosed.should_receive(:exists?).and_return(false)
      @sprint.closable?.should be_true
    end

    it 'should not be closed' do
      @sprint.should_receive(:closable?).and_return(false)
      @sprint.close.should be_false
      @sprint.closed?.should be_false
    end

    it 'should be closed' do
      @sprint.should_receive(:closable?).and_return(true)
      @sprint.close.should be_true
      @sprint.closed?.should be_true
    end
  end

  it 'should return the on air sprint' do
    sprint_1, sprint_2 = Factory(:sprint_1), Factory(:sprint_2)
    Sprint.on_air.nil?.should be_true

    sprint_1.sprint_backlogs.should_receive(:exists?).and_return(true)
    sprint_1.start
    Sprint.on_air.should eq(sprint_1)
  end

  it 'should reopen the closed sprint' do
    sprint = Factory(:sprint_1)
    sprint.sprint_backlogs.should_receive(:exists?).twice.and_return(true)
    sprint.start
    sprint.close

    sprint.closed?.should be_true
    sprint.reopen
    sprint.closed?.should be_false
  end

  it 'should return the total story points' do
    sprint = Factory(:sprint_1)
    create_product_backlogs = Factory(:create_product_backlogs)
    list_product_backlogs = Factory(:list_product_backlogs)
    sprint.sprint_backlogs.create!(:product_backlog => create_product_backlogs)
    sprint.sprint_backlogs.create!(:product_backlog => list_product_backlogs)

    sprint.story_points.should == create_product_backlogs.estimated_story_points + list_product_backlogs.estimated_story_points
  end
end
