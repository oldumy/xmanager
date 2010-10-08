Factory.define :admin, :class => User do |a|
  a.login 'admin'
  a.name 'Administrator'
  a.password '123456'
  a.password_confirmation '123456'
  a.association :role, :factory => :administrators
end

Factory.define :tower, :class => User do |pm|
  pm.login 'tower'
  pm.name 'Tower He'
  pm.password '123456'
  pm.password_confirmation '123456'
  pm.role do |role|
    Role.find_by_role_name(:product_owners) || Factory(:product_owners)
  end
end

Factory.define :oldumy, :class => User do |pm|
  pm.login 'oldumy'
  pm.name 'Online Dummy'
  pm.password '123456'
  pm.password_confirmation '123456'
  pm.role do |role|
    Role.find_by_role_name(:product_owners) || Factory(:product_owners)
  end
end

Factory.define :venus, :class => User do |pm|
  pm.login 'venus'
  pm.name 'Venus'
  pm.password '123456'
  pm.password_confirmation '123456'
  pm.association :role, :factory => :scrum_masters
end

Factory.define :jessimine, :class => User do |d|
  d.login 'jessimine'
  d.name 'Jessimine Tang'
  d.password '123456'
  d.password_confirmation '123456'
  d.role do |role|
    Role.find_by_role_name(:developers) || Factory(:developers)
  end
end

Factory.define :yanny, :class => User do |d|
  d.login 'yanny'
  d.name 'Yanny Yang'
  d.password '123456'
  d.password_confirmation '123456'
  d.role do |role|
    Role.find_by_role_name(:developers) || Factory(:developers)
  end
end

