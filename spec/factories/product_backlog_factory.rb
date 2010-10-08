Factory.define :create_product_backlogs, :class => ProductBacklog do |b|
  b.name 'Create product backlogs'
  b.priority 100
  b.estimated_story_points 3
  b.description 'Description of creating product backlogs'
  b.acceptance_criteria 'Acceptance criteria of creating product backlogs'
  b.project do |project|
    Project.find_by_name('XManager') || Factory(:xmanager)
  end
end

Factory.define :list_product_backlogs, :class => ProductBacklog do |b|
  b.name 'List product backlogs'
  b.priority 200
  b.estimated_story_points 2
  b.description 'Description of listing product backlogs'
  b.acceptance_criteria 'Acceptance criteria of listing product backlogs'
  b.project do |project|
    Project.find_by_name('XManager') || Factory(:xmanager)
  end
end

Factory.define :fake_product_backlog, :class => ProductBacklog do |b|
  b.name Faker::Lorem.sentence
  b.priority rand(10) * 100
  b.estimated_story_points rand(5) 
  b.description Faker::Lorem.sentences
  b.acceptance_criteria Faker::Lorem.sentences
end
