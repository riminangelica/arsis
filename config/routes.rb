UserAuth::Application.routes.draw do
  get "verifyreset/new"

  get "password_resets/new"

  resources :users do
    collection { post :import }
  end

  resources :attendances do
    collection { post :import }
  end

  resources :password_resets
  resources :verifyreset

  devise_for :admins
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  
  # SOA
  # Search User via ID Number
  match '/users/id/:id',
    :controller => :users,
    :action => "id"

  # Search User via First Name
  match '/users/firstname/:firstname',
    :controller => :users,
    :action => "firstname"

  # Search Users via Last Name
  match '/users/lastname/:lastname',
    :controller => :users,
    :action => "lastname"

  # Search Users via First Name and Last Name
  match '/users/firstname/:firstname/lastname/:lastname',
    :controller => :users,
    :action => "firstname_lastname"

  # Search Users under given Year Level
  match '/users/yr/:year',
    :controller => :users,
    :action => "yr"

  # Search Users under given Course ID
  match '/users/course/:course_id',
    :controller => :users,
    :action => "course"

  
  
  match ':controller(/:action(/:id))(.:format)'

  # USERS CONTROLLER
  
  # Sign Up Page
  match "signup", 
    :to => "users#new"

  
  # Edit Profile Controller
  match "edit", 
    :to => "users#edit",
    :via => :post
  
  # Edit Profile Controller
  match "update", 
    :to => "users#update"

  # Change Password Controller
  match "change_password/:idnum", 
    :to => "users#change_password"

  # Delete Dormer
  match "destroy", 
    :to => "users#destroy"
  
  # 
  match "index", 
    :to => "users#index"

  # EVENTS CONTROLLER
  # Edit Event Controller
  match "edit", 
    :to => "events#edit"

  # SESSIONS CONTROLLER
  # Login
  match "login",
    :to => "sessions#login"

  match "verify/:id",
    :to => "password_resets#verify",
    :as => "verify"

  # Logout
  match "logout", 
    :to => "sessions#logout"

  # Home
  match "home", 
    :to => "sessions#home"

  # View Profile
  match "profile/:user_id", 
    :to => "sessions#profile"

  # View Event
  match "event/:event_id", 
    :to => "sessions#viewevent",
    :as => "viewevent"

  # Edit Event
  match "edit/event/:event_id", 
    :to => "sessions#editevent",
    :as => "editevent"

  match "reset/:id/:answer", 
    :to => "password_resets#reset",
    :as => "reset"

  # Account Settings
  match "/setting/:idnum", 
    :to => "sessions#setting",
    :as => "setting"

  # Change Password
  match "changepw/:idnum", 
    :to => "sessions#changepw",
    :as => "changepw"

  # View Event Calendar
  match "eventcalendar", 
    :to => "sessions#eventcalendar"

  # View List of Events


  # View List of Events > Export Event to CSV
  match "event_to_csv/:id", 
    :to => "sessions#event_to_csv", 
    :as => "eventcsv"

  # Generate Dormer Database
  match "generatedb", 
    :to => "sessions#generatedb"

  # Generate Dormer Database > Export Dormerlist to CSV
  match "dormerlist_to_csv", 
    :to => "sessions#dormerlist_to_csv", 
    :as => "dormerlistcsv"

  # Track Progress
  match "progress/:user_id", 
    :to => "sessions#progress"

  # Upload Registration File
  match "regfile",
    :to => "sessions#upload_reg_file"

  # Contact Us
  match "message", 
    :to => "sessions#message"

  # Create Event
  match "newevent", 
    :to => "sessions#newevent"

  # View Members (PENDING)
  match "viewmembers", 
    :to => "sessions#viewmembers"

  # View Dorm Council
  match "dormcouncil", 
    :to => "sessions#view_dorm_council"

   

  # MESSAGES CONTROLLER
  # Contact Us
  match "create", 
    :to => "messages#create"

  # CONSOLIDATED CONTROLLER
  match "consolidated", 
    :to => "consolidated#index"
  
  # SEC GEN DASHBOARD (FOR TESTING ONLY)
  match "/secgen_dashboard", 
    :to => "secgen_dashboard#index", 
    :as => :secgen_dashboard
  match "/secgen_dashboard/import_dormers", 
    :to => "secgen_dashboard#import_dormers", 
    :as => :import_dormers
  match "/secgen_dashboard/import", 
    :to => "secgen_dashboard#import", 
    :as => :import, 
    :via => :post
  
  #resources :users , :controller => 'users', :collection => {:change_password_update => :put}

  root :to => 'sessions#home'
  
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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
