require 'spec_helper'

describe 'user_sessions/new.html.erb' do
  before(:each) do
    activate_authlogic
  end

  it "should render new user_session form" do
    @user_session = UserSession.new
    render

    rendered.should have_selector(:form, :action => user_session_path, :method => 'post') do |form|
      form.should have_selector("input#user_session_login", :name => "user_session[login]")
      form.should have_selector("input#user_session_password", :name => "user_session[password]")
      form.should have_selector("input#user_session_submit", :type => "submit")
    end
  end
end
