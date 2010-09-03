# encoding: utf-8
# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'spec_helper'

describe 'backlogs/edit.html.erb' do
  before(:each) do
    @project = Factory.create(:project)
    @backlog = Factory.create(:backlog, :project => @project)
  end

  it "should show edit.html" do
    render
    rendered.should contain("编辑待办事项")
  end

end