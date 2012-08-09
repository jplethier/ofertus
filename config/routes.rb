DealWitMe::Application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'

  # mount RailsBlogEngine::Engine => "/blog"

  # namespace :blog do 
  #   resources :blog_posts do
  #     resources :blog_comments
  #   end

  #   match '/new', :to => "blog_posts#new"
  #   match '/edit/:post_title', :to => "blog_posts#edit"
  #   match '/:post_title', :to => "blog_posts#show"
  #   root :to => "blog_posts#index"
  # end

  #TODO: Alterar as rotas, deveriam ser páginas estáticas
  get "pages/whoarewe"
  get "pages/help"
  get "pages/privacypolicy"
  get "pages/termsofuse"
  get "pages/how_it_works"

  #TODO: Melhorar as rotas do devise:
  #http://bunwich.blogspot.com/2011/07/make-rails-devise-routes-look-better.html
  #get \"users\/show\"

  devise_for :users, :controllers => {:registrations => "registrations", :omniauth_callbacks => "omniauth_callbacks"}

  resources :users do
    member do
      get 'follow'
      get 'unfollow'
    end
  end

  match '/deals/today/:category', :to => "deals#today"
  match '/deals/active/:category', :to => "deals#index"
  match "/deals/today", :to => "deals#today"

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

  # match '/mu-4b4c57f5-b0d80846-731c8e63-0f3bcb00', :to => "pages#blitz"

  match '/auth/failure' => 'application#failure'

  root :to => "deals#index"

  match "*a", :to => "application#error_routing"
end
