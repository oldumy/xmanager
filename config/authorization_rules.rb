authorization do
  role :guest do
    has_permission_on :user_sessions, :to => :create
  end

  role :administrators do
    has_permission_on :welcome, :to => :read
    has_permission_on :users, :to => :manage
  end

  role :product_owners do
    has_permission_on :welcome, :to => :read
    has_permission_on :user_sessions, :to => :manage
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
    has_permission_on :welcome, :to => :read
    has_permission_on :user_sessions, :to => :manage
    has_permission_on :projects, :to => :read
    has_permission_on :project_roles, :to => :read
    has_permission_on :sprints, :to => :read
    has_permission_on :backlogs, :to => :read
    has_permission_on :users, :to => :update
    has_permission_on :tasks, :to => :manage
    has_permission_on :project_burn_down_charts, :to => :read
    has_permission_on :sprint_burn_down_charts, :to => :read
  end
end

privileges do
  privilege :manage, :includes => [:create, :read, :update, :delete]
  privilege :create, :includes => [:new, :create]
  privilege :read, :includes => [:index, :show]
  privilege :update, :includes => [:show,:edit]
  privilege :delete, :includes => :destroy
end
