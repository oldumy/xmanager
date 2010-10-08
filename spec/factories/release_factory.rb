Factory.define(:v_1, :class => Release) do |r|
  r.name 'Version 1.0'
  r.description 'Description of version 1.0'
  r.estimated_released_on Date.parse('2010-09-30')
  r.project do |project|
    Project.find_by_name("XManager") || Factory(:xmanager)
  end
end

Factory.define(:v_2, :class => Release) do |r|
  r.name 'Version 2.0'
  r.description 'Description of version 2.0'
  r.estimated_released_on Date.parse('2010-10-31')
  r.project do |project|
    Project.find_by_name("XManager") || Factory(:xmanager)
  end
end
