authorization do
  role :guest do
    # add permissions for guests here, e.g.
    #has_permission_on :conferences, :to => :read
  end

  role :administrators do
    has_permission_on :users, :to => :manage
  end

  role :product_owners do
    has_permission_on :projects, :to => :manage
    has_permission_on :backlogs, :to => :manage
    has_permission_on :project_roles, :to => :manage
    has_permission_on :sprints, :to => :manage
    has_permission_on :users, :to => :update
    has_permission_on :tasks, :to => :manage
    has_permission_on :project_burn_down_charts, :to => :read
    has_permission_on :sprint_burn_down_charts, :to => :read
  end

  role :developers do
    has_permission_on :projects, :to => :read
    has_permission_on :project_roles, :to => :read
    has_permission_on :sprints, :to => :read
    has_permission_on :backlogs, :to => :read
    has_permission_on :users, :to => :update
    has_permission_on :tasks, :to => :manage
    has_permission_on :project_burn_down_charts, :to => :read
    has_permission_on :sprint_burn_down_charts, :to => :read
  end
  
  # permissions on other roles, such as
  #role :admin do
  #  has_permission_on :conferences, :to => :manage
  #end
end

privileges do
  # default privilege hierarchies to facilitate RESTful Rails apps
  privilege :manage, :includes => [:create, :read, :update, :delete]
  privilege :read, :includes => [:index, :show]
  privilege :create, :includes => :new
  privilege :update, :includes => [:show,:edit]
  privilege :delete, :includes => :destroy
end
