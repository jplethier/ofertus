DealWitMe::Application.routes.draw do

  mount RailsBlogEngine::Engine => "/blog"

  #TODO: Alterar as rotas, deveriam ser páginas estáticas
  get "pages/whoarewe"
  get "pages/help"
  get "pages/privacypolicy"
  get "pages/termsofuse"
  get "pages/how_it_works"

  #TODO: Melhorar as rotas do devise:
  #http://bunwich.blogspot.com/2011/07/make-rails-devise-routes-look-better.html
  #get \"users\/show\"
  get "deals/today"

  devise_for :users, :controllers => {:registrations => "registrations", :omniauth_callbacks => "omniauth_callbacks"}

  resources :users do
    member do
      get 'follow'
      get 'unfollow'
    end
  end

  resources :deals do
    resources :comments

    collection do
      get 'share'
    end

    member do
      get 'upvote'
      get 'downvote'
      get 'unvote'
    end
  end

  match '/mu-4b4c57f5-b0d80846-731c8e63-0f3bcb00', :to => "pages#blitz"

  match '/deals/today/:category', :to => "deals#today"
  match '/deals/active/:category', :to => "deals#index"
  match '/auth/failure' => 'applications#failure'

  root :to => "deals#index"

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
  # match ':controller(/:action(/:id(.:format)))'
end
