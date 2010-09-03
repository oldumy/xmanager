require 'spec_helper'

describe Task do
  describe 'Task validations' do
    it 'should have a name' do
      validates_presence_of :name
    end

    it 'should have a unique name' do
      task = Factory.build(:task, :name => Factory(:task).name)
      task.should_not be_valid
      task.should have(1).errors_on(:name)
    end

    private

    def validates_presence_of(attr)
        task = Factory.build(:task, attr.to_sym => nil, :user => Factory(:user, :login => 'iii.gaols'))
        task.should_not be_valid
    end
  end

  describe 'Update progress of a task' do
    it 'should update progress correctly' do
      task = Factory(:task)
      params = {
        :id => task.id,
        :task => {
          :progress => 20,
          :surplus_workload => 2
        }
      }
      task.update_task_progress(params[:task]).should be_true
      TaskHistory.all.should have(1).tasks
      TaskHistory.first.date.should == Time.now.to_date
    end
  end
end
