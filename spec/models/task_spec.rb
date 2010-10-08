require 'spec_helper'

describe Task do
  describe 'Validation' do
    describe 'Name' do
      before(:each) do
        @task = Task.new
      end

      it 'should not be nil' do
        @task.should have(2).errors_on(:name)
      end

      it 'should have at least 1 character' do
        @task.name = ''
        @task.should have(2).errors_on(:name)
      end

      it 'should be valid' do
        @task.name = 'a'
        @task.should have(:no).error_on(:name)
      end

      it 'should have no more than 100 characters' do
        @task.name = 'a' * 101
        @task.should have(1).error_on(:name)
      end
    end

    it 'should belong to a product backlog' do
      task = Task.new
      task.should have(1).error_on(:product_backlog)
    end
  end

  describe 'close' do
    before(:each) do
      @task = Factory(:task)
    end

    it 'is not closable if no worklog' do
      @task.worklogs.should_receive(:exists?).and_return(false)
      @task.closable?.should be_false
    end

    it 'is not closable if not be done' do
      @task.worklogs.should_receive(:exists?).and_return(true)
      @task.worklogs.stub_chain(:last, :remaining_hours).and_return(1)
      @task.closable?.should be_false
    end

    it 'is closable' do
      @task.worklogs.should_receive(:exists?).and_return(true)
      @task.worklogs.stub_chain(:last, :remaining_hours).and_return(0)
      @task.closable?.should be_true
    end

    it 'should not be closed' do
      @task.should_receive(:closable?).and_return(false)
      @task.close.should be_false
      @task.closed?.should be_false
    end

    it 'should be closed' do
      @task.should_receive(:closable?).and_return(true)
      @task.close.should be_true
      @task.closed?.should be_true
    end
  end

  describe 'reopen' do
    before(:each) do
      @task = Factory(:task)
    end

    it 'should be reopened' do
      @task.should_receive(:closable?).and_return(true)
      @task.close

      @task.reopen
      @task.closed?.should be_false
    end
  end
end
