require 'spec_helper'

describe ProductBacklog do
  it 'should return the unscheduled product backlogs' do
    create_product_backlogs = Factory(:create_product_backlogs)
    list_product_backlogs = Factory(:list_product_backlogs)
    sprint = Factory(:sprint_1)

    sprint_backlog = SprintBacklog.create!(:sprint => sprint, :product_backlog => create_product_backlogs)

    unscheduled = ProductBacklog.unscheduled
    unscheduled.count.should == 1
    unscheduled.first.should == list_product_backlogs
  end

  describe 'close' do
    before(:each) do
      @product_backlog = Factory(:create_product_backlogs)
    end

    it 'is not closable if no task' do
      @product_backlog.tasks.should_receive(:exists?).and_return(false)
      @product_backlog.closable?.should be_false
    end

    it 'is not closable if a task is open' do
      @product_backlog.tasks.should_receive(:exists?).and_return(true)
      @product_backlog.tasks.unclosed.should_receive(:exists?).and_return(true)
      @product_backlog.closable?.should be_false
    end

    it 'is closable' do
      @product_backlog.tasks.should_receive(:exists?).and_return(true)
      @product_backlog.tasks.unclosed.should_receive(:exists?).and_return(false)
      @product_backlog.closable?.should be_true
    end

    it 'is not closed' do
      @product_backlog.should_receive(:closable?).and_return(false)
      @product_backlog.close.should be_false
      @product_backlog.closed?.should be_false
    end
     
    it 'is closed' do
      @product_backlog.should_receive(:closable?).and_return(true)
      @product_backlog.close.should be_true
      @product_backlog.closed?.should be_true
    end
  end

  describe 'reopen' do
    before(:each) do
      @product_backlog = Factory(:create_product_backlogs)
    end

    it 'is reopened' do
      @product_backlog.should_receive(:closable?).and_return(true)
      @product_backlog.close

      @product_backlog.reopen
      @product_backlog.closed?.should be_false
    end
  end
end
