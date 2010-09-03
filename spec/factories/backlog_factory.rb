# encoding: utf-8
Factory.define :backlog do |u|
    u.what 'aaaaaaaaaaaaaa'
    u.why  'bbbbbbbbbbbbb'
    u.sequence(:level) { |n| 100+n }
    u.story_points 2
    u.actual_story_points 1
    u.inspection 'ccccccccccc'
    u.status 1
    u.project { |p| p.association(:project)}
    u.association(:sprint)
    u.project_role {|p| p.association(:project_role)}

  end
