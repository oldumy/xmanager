require File.dirname(__FILE__) + '/../view_spec_helper'

describe 'sprints/on_air.html.erb' do

  it 'should notice "No record found."' do
    @project = Factory(:xmanager)
    current_user(:oldumy)
    render

    rendered.should have_selector("p#no-record-found", :content => "No record found.")
  end
  
  describe 'with a sprint on air' do
    before(:each) do
      @project = Factory(:xmanager)
      @sprint = Factory(:sprint_1)
      @sprint.sprint_backlogs.create!(:product_backlog => Factory(:fake_product_backlog, :project => @project))
      @sprint.start
    end

    describe 'product owner' do
      before(:each) do
        @current_user = current_user(:oldumy)
      end
      
      describe 'sprint' do
        before(:each) do
          render
        end

        it 'should show the sprint properties' do
          rendered.should have_selector("#sprint-#{@sprint.id}") do |div|
            div.should have_selector("h1", :content => @sprint.name)
            div.should have_selector("h1>span.red", :content => "#{@sprint.estimated_started_on}..#{@sprint.estimated_closed_on}")
            div.should have_selector("h1>span", :content => @sprint.description)
          end
        end

        it 'should have a close link' do
          rendered.should have_selector("#sprint-#{@sprint.id}>h1>span.actions>a",
                                        :content => "Close",
                                        :href => close_sprint_path(@sprint),
                                        "data-method" => 'put')
        end
      end

      describe 'sprint backlogs' do
        before(:each) do
          @sprint_backlog = @sprint.sprint_backlogs.create!(:product_backlog => Factory(:create_product_backlogs))
          sprint_backlogs = [@sprint_backlog]
          @sprint.stub(:sprint_backlogs).and_return(sprint_backlogs)
          sprint_backlogs.stub(:exists?).and_return(true)
        end

        it 'should have a sprint backlogs list' do
          render
          rendered.should have_selector(".sprint-backlogs")
        end

        it 'should list the sprint backlogs' do
          render

          rendered.should have_selector(".sprint-backlogs") do |div|
            div.should have_selector("#sprint-backlog-#{@sprint_backlog.id}>h1", :content => @sprint_backlog.product_backlog.name)
            div.should have_selector("#sprint-backlog-#{@sprint_backlog.id}>h1>span", :content => "Priority(#{@sprint_backlog.product_backlog.priority})")
            div.should have_selector("#sprint-backlog-#{@sprint_backlog.id}>h1>span", :content => "Estimated Story Points(#{@sprint_backlog.product_backlog.estimated_story_points})")
            
            div.should have_selector("#sprint-backlog-#{@sprint_backlog.id}>h1>span.actions") do |span|
              span.should have_selector("a", :content => "New Task", :href => new_product_backlog_task_path(@sprint_backlog.product_backlog))
              span.should have_selector("a", :content => "Close", :href => close_product_backlog_path(@sprint_backlog.product_backlog))
            end
          end
        end

        it 'should only have a reopen link' do 
          @sprint_backlog.product_backlog.stub(:closed?).and_return(true)
          render

          rendered.should have_selector("#sprint-backlog-#{@sprint_backlog.id}>h1>span.actions") do |span|
            span.should_not have_selector("a", :content => "New Task", :href => new_product_backlog_task_path(@sprint_backlog.product_backlog))
            span.should_not have_selector("a", :content => "Close", :href => close_product_backlog_path(@sprint_backlog.product_backlog))
            span.should have_selector("a", :content => "Reopen", :href => reopen_product_backlog_path(@sprint_backlog.product_backlog))
          end

        end

        describe 'Task' do 
          before(:each) do
            team_member = @project.team_members.create!(:user => @current_user)
            @task = @sprint_backlog.product_backlog.tasks.create!(Factory.attributes_for(:task, :team_member => team_member))
            @sprint_backlog.product_backlog.should_receive(:tasks).and_return([@task])
            @task.worklogs.create!(Factory.attributes_for(:worklog))
          end

          it 'should have the name of the team member' do
            render
            rendered.should have_selector("#task-#{@task.id}>h1:contains('#{@task.name}')") do |h1|
              h1.should have_selector(:span, :content => @task.team_member.name)
            end
          end

          it 'should have the estimated hours of the task' do
            render
            rendered.should have_selector("#task-#{@task.id}>h1:contains('#{@task.name}')") do |h1|
              h1.should have_selector(:span, :content => "Estimated Hours(#{@task.estimated_hours})")
            end
          end

          it 'should have the remaining hours of the task' do
            render
            rendered.should have_selector("#task-#{@task.id}>h1:contains('#{@task.name}')") do |h1|
              h1.should have_selector(:span, :content => "Remaining Hours(#{@task.worklogs.last.remaining_hours})")
            end
          end

          it 'should have the worklogs count of the task' do
            render
            rendered.should have_selector("#task-#{@task.id}>h1:contains('#{@task.name}')") do |h1|
              h1.should have_selector(:span, :content => "Logs(#{@task.worklogs.count})")
            end
          end

          describe 'actions on the task' do
            it 'should have a log link if the task is assigned to @current_user' do
              @task.stub(:closable?).and_return(false)
              render

              @task.team_member.user.should eq(@current_user)
              rendered.should have_selector("#task-#{@task.id}>h1:contains('#{@task.name}')") do |h1|
                h1.should have_selector("span.actions>a", :href => new_task_worklog_path(@task), :content => 'Log')
              end
            end
            
            it 'should not have a log link if the task is closable' do
              @task.stub(:closable?).and_return(true)
              render

              rendered.should have_selector("#task-#{@task.id}>h1:contains('#{@task.name}')") do |h1|
                h1.should_not have_selector("span.actions>a", :href => new_task_worklog_path(@task), :content => 'Log')
              end
            end

            it 'should not have a close link if the task is not closable' do
              @task.stub(:closable?).and_return(false)
              render
              rendered.should have_selector("#task-#{@task.id}>h1:contains('#{@task.name}')") do |h1|
                h1.should_not have_selector("span.actions>a", :href => close_task_path(@task), :content => 'Close')
              end
            end

            it 'should have a close link if the task is closable' do
              @task.stub(:closable?).and_return(true)
              render
              rendered.should have_selector("#task-#{@task.id}>h1:contains('#{@task.name}')") do |h1|
                h1.should have_selector("span.actions>a", :href => close_task_path(@task), :content => 'Close')
              end
            end

            it 'should have a edit link' do
              render
              rendered.should have_selector("#task-#{@task.id}>h1:contains('#{@task.name}')") do |h1|
                h1.should have_selector("span.actions>a", :href => edit_product_backlog_task_path(@task.product_backlog, @task), :content => 'Edit' )
              end
            end

            it 'should have a delete link' do
              render
              rendered.should have_selector("#task-#{@task.id}>h1:contains('#{@task.name}')") do |h1|
                h1.should have_selector("span.actions>a", :href => product_backlog_task_path(@task.product_backlog, @task), :content => 'Delete' )
              end
            end

            it 'should have a reopen link' do
              @task.stub(:closed?).and_return(true)
              render
              rendered.should have_selector("#task-#{@task.id}>h1:contains('#{@task.name}')") do |h1|
                h1.should have_selector("span.actions>a", :content => 'Reopen', :href => reopen_task_path(@task))
              end
            end
          end
        end
      end
    end

    describe 'for scrum masters' do
      before(:each) do
        @current_user = current_user(:venus)
      end

      describe 'sprint' do
        it 'should render the sprint head' do
          render
          rendered.should have_selector(".sprint>h1:contains('#{@sprint.name}')") do |h1|
            h1.should have_selector(:span, :content => "#{@sprint.estimated_started_on}..#{@sprint.estimated_closed_on}")
            h1.should have_selector(:span, :content => "#{@sprint.description}")
            h1.should_not have_selector("span.actions")
          end
        end

        it 'should not have management links' do
          render
          rendered.should_not have_selector(".sprint>h1:contains('#{@sprint.name}')>span.actions")
        end
      end

      describe 'sprint backlogs' do
        before(:each) do
          @sprint_backlog = @sprint.sprint_backlogs.create!(:product_backlog => Factory(:create_product_backlogs))
          sprint_backlogs = [@sprint_backlog]
          @sprint.stub(:sprint_backlogs).and_return(sprint_backlogs)
          sprint_backlogs.stub(:exists?).and_return(true)
        end

        it 'should have a new task link' do
          sprint_backlog = @sprint.sprint_backlogs.first
          render

          rendered.should have_selector("#sprint-backlog-#{sprint_backlog.id}>h1:contains('#{sprint_backlog.product_backlog.name}')>span.actions") do |span|
            span.should have_selector(:a, :href => new_product_backlog_task_path(sprint_backlog.product_backlog), :content => 'New Task')
          end
        end

        describe 'Task' do
          before(:each) do
            team_member = @project.team_members.create!(:user => @current_user)
            @task = @sprint_backlog.product_backlog.tasks.create!(Factory.attributes_for(:task, :team_member => team_member))
            @sprint_backlog.product_backlog.stub(:tasks).and_return([@task])
            @task.worklogs.create!(Factory.attributes_for(:worklog))
          end

          it 'should have the name of the team member' do
            render
            rendered.should have_selector("#task-#{@task.id}>h1:contains('#{@task.name}')") do |h1|
              h1.should have_selector(:span, :content => @task.team_member.name)
            end
          end

          it 'should have the estimated hours of the task' do
            render
            rendered.should have_selector("#task-#{@task.id}>h1:contains('#{@task.name}')") do |h1|
              h1.should have_selector(:span, :content => "Estimated Hours(#{@task.estimated_hours})")
            end
          end

          it 'should have the remaining hours of the task' do
            render
            rendered.should have_selector("#task-#{@task.id}>h1:contains('#{@task.name}')") do |h1|
              h1.should have_selector(:span, :content => "Remaining Hours(#{@task.worklogs.last.remaining_hours})")
            end
          end

          it 'should have the worklogs count of the task' do
            render
            rendered.should have_selector("#task-#{@task.id}>h1:contains('#{@task.name}')") do |h1|
              h1.should have_selector(:span, :content => "Logs(#{@task.worklogs.count})")
            end
          end

          describe 'actions on the task' do
            it 'should have a edit link' do
              render
              rendered.should have_selector("#task-#{@task.id}>h1:contains('#{@task.name}')") do |h1|
                h1.should have_selector("span.actions>a", :href => edit_product_backlog_task_path(@task.product_backlog, @task), :content => 'Edit' )
              end
            end

            it 'should have a delete link' do
              render
              rendered.should have_selector("#task-#{@task.id}>h1:contains('#{@task.name}')") do |h1|
                h1.should have_selector("span.actions>a", :href => product_backlog_task_path(@task.product_backlog, @task), :content => 'Delete' )
              end
            end

            it 'should have a reopen link' do
              @task.stub(:closed?).and_return(true)
              render
              rendered.should have_selector("#task-#{@task.id}>h1:contains('#{@task.name}')") do |h1|
                h1.should have_selector("span.actions>a", :href => reopen_task_path(@task), :content => 'Reopen' )
              end
            end
          end
        end
      end
    end

    describe 'for develpers' do
      before(:each) do
        @current_user = current_user(:jessimine)
      end

      it 'should render the sprint head' do
        render

        rendered.should have_selector(".sprint>h1:contains('#{@sprint.name}')") do |h1|
          h1.should have_selector(:span, :content => "#{@sprint.estimated_started_on}..#{@sprint.estimated_closed_on}")
          h1.should have_selector(:span, :content => "#{@sprint.description}")
          h1.should_not have_selector("span.actions")
        end
      end

      describe 'sprint backlogs' do
        before(:each) do
          @sprint_backlog = @sprint.sprint_backlogs.create!(:product_backlog => Factory(:create_product_backlogs))
          sprint_backlogs = [@sprint_backlog]
          @sprint.stub(:sprint_backlogs).and_return(sprint_backlogs)
          sprint_backlogs.stub(:exists?).and_return(true)
        end

        describe 'Task' do
          before(:each) do
            team_member = @project.team_members.create!(:user => @current_user)
            @task = @sprint_backlog.product_backlog.tasks.create!(Factory.attributes_for(:task, :team_member => team_member))
            @sprint_backlog.product_backlog.stub(:tasks).and_return([@task])
            @task.worklogs.create!(Factory.attributes_for(:worklog))
            render
          end

          it 'should have the name of the team member' do
            rendered.should have_selector("#task-#{@task.id}>h1:contains('#{@task.name}')") do |h1|
              h1.should have_selector(:span, :content => @task.team_member.name)
            end
          end

          it 'should have the estimated hours of the task' do
            rendered.should have_selector("#task-#{@task.id}>h1:contains('#{@task.name}')") do |h1|
              h1.should have_selector(:span, :content => "Estimated Hours(#{@task.estimated_hours})")
            end
          end

          it 'should have the remaining hours of the task' do
            render
            rendered.should have_selector("#task-#{@task.id}>h1:contains('#{@task.name}')") do |h1|
              h1.should have_selector(:span, :content => "Remaining Hours(#{@task.worklogs.last.remaining_hours})")
            end
          end

          it 'should have the worklogs count of the task' do
            render
            rendered.should have_selector("#task-#{@task.id}>h1:contains('#{@task.name}')") do |h1|
              h1.should have_selector(:span, :content => "Logs(#{@task.worklogs.count})")
            end
          end

          describe 'actions on the task' do
            it 'should have a edit link' do
              rendered.should have_selector("#task-#{@task.id}>h1:contains('#{@task.name}')") do |h1|
                h1.should_not have_selector("span.actions>a", :href => edit_product_backlog_task_path(@task.product_backlog, @task), :content => 'Edit' )
              end
            end

            it 'should have a delete link' do
              rendered.should have_selector("#task-#{@task.id}>h1:contains('#{@task.name}')") do |h1|
                h1.should_not have_selector("span.actions>a", :href => product_backlog_task_path(@task.product_backlog, @task), :content => 'Delete' )
              end
            end
          end
        end
      end
    end
  end
end
