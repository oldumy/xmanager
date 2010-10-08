Factory.define :sprint_1, :class => Sprint do |s|
  s.name 'Sprint 1'
  s.description 'Description of sprint 1'
  s.estimated_started_on Date.parse('2010-09-16')
  s.estimated_closed_on Date.parse('2010-09-30')
  s.release do |release|
    Release.find_by_name("Version 1.0") || Factory(:v_1)
  end
end

Factory.define :sprint_2, :class => Sprint do |s|
  s.name 'Sprint 2'
  s.description 'Description of sprint 2'
  s.estimated_started_on Date.parse('2010-10-01')
  s.estimated_closed_on Date.parse('2010-10-15')
  s.release do |release|
    Release.find_by_name("Version 1.0") || Factory(:v_1)
  end
end
