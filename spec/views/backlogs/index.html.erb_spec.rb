# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'spec_helper'

describe 'backlogs/index.html.erb' do
  before(:each) do
    @project = Factory.create(:project)
    @backlogs = [Factory.create(:backlog, :project => @project)].paginate(:per_page => 1)
  end

  it "should show index.html" do
    render
    rendered.should contain("aaaaaaaaaaaaaa")
  end
  
end


