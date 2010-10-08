Xmanager::Application.routes.draw do

  get "project_burn_down_charts/index"

  get "sprint_burn_down_chart/index"

  match 'signin' => 'user_sessions#new'

  resources :users
  resource :user_session
  root :to => "welcome#index"

  resources :projects do
    resources :burndown_charts
    resources :product_backlogs
    resources :project_plannings
    resources :releases
    resources :sprints do
      get 'on_air', :on => :collection
    end
    resources :team_members
  end

  resources :product_backlogs do 
    resources :tasks
    put 'close', :on => :member
    put 'reopen', :on => :member
  end

  resources :releases do
    put 'release', :on => :member
    put 'turnback', :on => :member
    resources :sprints
  end

  resources :sprints do
    put 'close', :on => :member
    put 'reopen', :on => :member
    put 'start', :on => :member

    resources :sprint_backlogs
  end

  resources :tasks do
    put 'close', :on => :member
    put 'reopen', :on => :member
    resources :worklogs
  end

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
