require 'spec_helper'

describe Worklog do
  describe 'Validation' do
    before(:each) do
      @worklog = Worklog.new
    end

    describe 'remaining hours' do
      it 'should not be nil' do
        @worklog.should have(2).error_on(:remaining_hours)
      end

      it 'should be greater than or equal to 0' do
        @worklog.remaining_hours = -1
        @worklog.should have(1).error_on(:remaining_hours)
      end
    end

    it 'should have a task' do
      @worklog.should have(1).error_on(:task)
    end
  end
end
