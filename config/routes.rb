DealWitMe::Application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'

  namespace :admin do
    resources :users
    resources :deals

    root :to => "users#index"
  end

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

  match "whoarewe",       :to => "pages#whoarewe"
  match "help",           :to => "pages#help"
  match "privacypolicy",  :to => "pages#privacypolicy"
  match "termsofuse",     :to => "pages#termsofuse"
  match "how_it_works",   :to => "pages#how_it_works"
  match "show_video",     :to => "pages#show_video", :as => 'show_video'

  match '/deals/feed' => 'deals#feed', :as => :feed, :defaults => { :format => 'atom' }

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

  match '/deals/active/:category', :to => "deals#index"

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

  root :to => "pages#home"

  match "*a", :to => "application#error_routing"
end
