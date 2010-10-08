require 'spec_helper'

describe Release do
  describe "Validate" do
    describe "Name" do
      it "should not be nil" do
        release = Release.new
        release.should have(2).error_on(:name)
      end

      it "should have at least one character" do
        release = Release.new(:name => '')
        release.should have(2).error_on(:name)

        release.name = 'a'
        release.should have(:no).error_on(:name)
      end

      it "should have less than 100 characters" do
        release = Release.new(:name => 'a' * 100)
        release.should have(:no).error_on(:name)

        release.name = 'a' * 101
        release.should have(1).error_on(:name)
      end
    end

    describe "Project" do
      it "should have a project" do
        release = Release.new
        release.should have(1).error_on(:project)

        release.project = Project.new
        release.should have(:no).error_on(:project)
      end
    end
  end

  describe 'Release' do
    before(:each) do
      @release = Factory(:v_1)
    end

    it 'is not releasable if no sprint' do
      @release.sprints.should_receive(:count).and_return(0)
      @release.releasable?.should be_false
    end

    it 'is not releasable if a sprint is open' do
      @release.sprints.should_receive(:count).and_return(1)
      @release.sprints.unclosed.should_receive(:exists?).and_return(true)
      @release.releasable?.should be_false
    end

    it 'is releasable' do
      @release.sprints.should_receive(:count).and_return(1)
      @release.sprints.unclosed.should_receive(:exists?).and_return(false)
      @release.releasable?.should be_true
    end

    it 'is not released' do
      @release.should_receive(:releasable?).and_return(false)
      @release.release.should be_false
      @release.released?.should be_false
    end

    it 'is released' do
      @release.should_receive(:releasable?).and_return(true)
      @release.release.should be_true
      @release.released?.should be_true
    end
  end

  it 'should return the total story points of the release' do
    release = Factory(:v_1)
    sprint_1 = Factory(:sprint_1, :release => release)
    sprint_2 = Factory(:sprint_2, :release => release)
    
    create_product_backlogs = Factory(:create_product_backlogs)
    list_product_backlogs = Factory(:list_product_backlogs)
    sprint_1.sprint_backlogs.create!(:product_backlog => create_product_backlogs)
    sprint_2.sprint_backlogs.create!(:product_backlog => list_product_backlogs)

    release.story_points.should == sprint_1.story_points + sprint_2.story_points
  end
end
