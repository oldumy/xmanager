require 'spec_helper'

describe ProductBacklogsController do

  before(:each) do
    activate_authlogic
    @current_user = Factory(:oldumy)
    UserSession.create @current_user
  end

  describe "GET 'index'" do
    it "should assign product backlogs as @product_backlogs" do
      @project = Factory(:xmanager)
      @product_backlogs = []
      Project.should_receive(:find).with(@project.id).and_return(@project)
      @project.product_backlogs.should_receive(:unscheduled).and_return(@product_backlogs)
      @product_backlogs.should_receive(:paginate).and_return(@product_backlogs)
      get 'index', :project_id => @project.id

      assigns(:project).should eq(@project)
      assigns(:product_backlogs).should eq(@product_backlogs)
    end
  end

  describe "GET 'new'" do
    it 'should assign a newly product backlog as @product_backlog' do
      project = Factory(:xmanager)
      product_backlog = Factory.build(:create_product_backlogs, :project => project)
      Project.should_receive(:find).with(project.id).and_return(project)
      project.product_backlogs.should_receive(:build).and_return(product_backlog)

      get :new, :project_id => project.id
      assigns(:product_backlog).should eq(product_backlog)
    end
  end

  describe "POST 'create'" do
    before(:each) do 
      @project, @product_backlog = Factory(:xmanager), Factory.build(:create_product_backlogs)
      Project.should_receive(:find).with(@project.id).and_return(@project)
      @project.product_backlogs.should_receive(:build).and_return(@product_backlog)
    end
    describe "with valid params" do
      it "should be successful and redirect to the product backlogs page" do
        @product_backlog.should_receive(:save).and_return(true)

        post 'create', :project_id => @project.id 
        assigns(:project).should be(@project)
        assigns(:product_backlog).should be(@product_backlog)
        response.should redirect_to(project_product_backlogs_url(@project))
      end
    end

    describe "with invalid params" do
      it "should re-render 'new' template" do
        @product_backlog.should_receive(:save).and_return(false)
        post 'create', :project_id => @project.id
        response.should render_template('new')
      end
    end
  end

  describe "GET 'edit'" do
    it "should assign the product backlog to be modified as @product_backlog" do
      product_backlog = Factory(:create_product_backlogs)
      ProductBacklog.should_receive(:find).with(product_backlog.id).and_return(product_backlog)
      get 'edit', :project_id => product_backlog.project.id, :id => product_backlog.id 
      assigns(:product_backlog).should eq(product_backlog)
    end
  end

  describe "PUT 'update'" do
    before(:each) do
      @product_backlog = Factory(:create_product_backlogs)
      ProductBacklog.should_receive(:find).with(@product_backlog.id).and_return(@product_backlog)
    end

    describe "with valid params" do
      it "should update the product backlog and redirect to the product backlogs page" do
        @product_backlog.should_receive(:update_attributes).and_return(true)

        put 'update', :project_id => @product_backlog.project.id, :id => @product_backlog.id
        assigns(:product_backlog).should eq(@product_backlog)
        response.should redirect_to(project_product_backlogs_url(@product_backlog.project))
      end
    end

    describe "with invalid params" do
      it "should re-render the template 'edit'" do
        @product_backlog.should_receive(:update_attributes).and_return(false)

        put 'update', :project_id => @product_backlog.project.id, :id => @product_backlog.id
        assigns(:product_backlog).should eq(@product_backlog)
        response.should render_template('edit')
      end
    end
  end

  describe "DELETE 'destroy'" do
    it "should be deleted and then redirected to the product backlogs page" do
      product_backlog = Factory(:create_product_backlogs)
      ProductBacklog.should_receive(:find).with(product_backlog.id).and_return(product_backlog)
      product_backlog.should_receive(:destroy)

      delete 'destroy', :project_id => product_backlog.project.id, :id => product_backlog.id
      response.should redirect_to(project_product_backlogs_url(product_backlog.project))
    end
  end

  describe 'PUT close' do
    before(:each) do
      @product_backlog = Factory(:create_product_backlogs)
      ProductBacklog.should_receive(:find).with(@product_backlog.id).and_return(@product_backlog)
    end

    it 'should close the requested product backlog' do
      @product_backlog.should_receive(:close)
      
      put :close, :id => @product_backlog.id
    end

    it 'should notice a task is still open' do
      @product_backlog.should_receive(:close).and_return(false)
      
      put :close, :id => @product_backlog.id
      flash[:notice].should == 'No task found or a task is still open.'
    end

    it 'should redirect to the on air sprint page' do
      @product_backlog.should_receive(:close).and_return(true)
      
      put :close, :id => @product_backlog.id
      response.should redirect_to(on_air_project_sprints_url(@product_backlog.project))
    end
  end

  describe 'PUT reopen' do
    it 'should reopen the requested product backlog' do
      @product_backlog = Factory(:create_product_backlogs)
      ProductBacklog.should_receive(:find).with(@product_backlog.id).and_return(@product_backlog)
      @product_backlog.should_receive(:reopen)

      put :reopen, :id => @product_backlog.id
    end
  end
end
