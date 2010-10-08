require 'spec_helper'

describe TeamMember do
  it "should belong to a project" do
    member = TeamMember.new
    member.should have(1).error_on(:project)
  end

  it "should belong to a user" do
    member = TeamMember.new
    member.should have(1).error_on(:user)
  end
end
