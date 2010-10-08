require 'spec_helper'

describe SprintBacklog do
  describe 'Validation' do
    before(:each) do
      @sprint_backlog = SprintBacklog.new
    end

    it 'should have a sprint' do
      @sprint_backlog.should have(1).error_on(:sprint)
    end

    it 'should have a product backlog' do
      @sprint_backlog.should have(1).error_on(:product_backlog)
    end
  end
end
