authorization do
  role :guest do
    has_permission_on :user_sessions, :to => :create
  end

  role :administrators do
    has_permission_on :users, :to => :manage
    has_permission_on :user_sessions, :to => :manage
    has_permission_on :welcome, :to => :read
  end

  role :product_owners do
    has_permission_on :burndown_charts, :to => :read
    has_permission_on :product_backlogs, :to => :manage
    has_permission_on :product_backlogs, :to => :close
    has_permission_on :product_backlogs, :to => :reopen
    has_permission_on :project_plannings, :to => :index
    has_permission_on :projects, :to => :manage
    has_permission_on :releases, :to => :manage
    has_permission_on :releases, :to => :release
    has_permission_on :releases, :to => :turnback
    has_permission_on :sprint_backlogs, :to => :manage
    has_permission_on :sprints, :to => :manage
    has_permission_on :sprints, :to => :start
    has_permission_on :sprints, :to => :close
    has_permission_on :sprints, :to => :reopen
    has_permission_on :sprints, :to => :on_air
    has_permission_on :tasks, :to => :manage
    has_permission_on :tasks, :to => :close
    has_permission_on :tasks, :to => :reopen
    has_permission_on :team_members, :to => :manage
    has_permission_on :worklogs, :to => :manage

    has_permission_on :project_burn_down_charts, :to => :read
    has_permission_on :sprint_burn_down_charts, :to => :read

    has_permission_on :user_sessions, :to => :manage
    has_permission_on :users, :to => [:show, :update] do
      if_attribute :id => is { user.id }
    end
    has_permission_on :welcome, :to => :read
  end

  role :scrum_masters do
    has_permission_on :burndown_charts, :to => :read
    has_permission_on :product_backlogs, :to => :read
    has_permission_on :project_plannings, :to => :index
    has_permission_on :projects, :to => :read
    has_permission_on :releases, :to => :read
    has_permission_on :sprints, :to => :on_air
    has_permission_on :sprint_backlogs, :to => :read
    has_permission_on :tasks, :to => :manage
    has_permission_on :tasks, :to => :close
    has_permission_on :tasks, :to => :reopen
    has_permission_on :worklogs, :to => :manage

    has_permission_on :user_sessions, :to => :manage
    has_permission_on :users, :to => [:show, :update] do
      if_attribute :id => is { user.id }
    end
    has_permission_on :welcome, :to => :read
  end

  role :developers do
    has_permission_on :burndown_charts, :to => :read
    has_permission_on :product_backlogs, :to => :read
    has_permission_on :project_plannings, :to => :index
    has_permission_on :projects, :to => :read
    has_permission_on :releases, :to => :read
    has_permission_on :sprints, :to => :on_air
    has_permission_on :sprint_backlogs, :to => :read
    has_permission_on :worklogs, :to => :manage

    has_permission_on :user_sessions, :to => :manage
    has_permission_on :users, :to => [:show, :update] do
      if_attribute :id => is { user.id }
    end
    has_permission_on :welcome, :to => :read
  end
end

privileges do
  privilege :manage, :includes => [:create, :read, :update, :delete]
  privilege :create, :includes => [:new, :create]
  privilege :read, :includes => [:index, :show]
  privilege :update, :includes => [:show,:edit]
  privilege :delete, :includes => :destroy
end
