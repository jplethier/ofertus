DealWitMe::Application.routes.draw do

  root :to => "pages#home"

  ActiveAdmin.routes(self)

  match 'lomadee', :to => 'application#lomadee'

  match 'invite/:username', to: 'users#invite', as: 'invitation'

  mount Ckeditor::Engine => '/ckeditor'

  match "whoarewe",       :to => "pages#whoarewe"
  match "partners",       :to => "pages#partners"
  match "help",           :to => "pages#help"
  match "privacypolicy",  :to => "pages#privacypolicy"
  match "termsofuse",     :to => "pages#termsofuse"
  match "how_it_works",   :to => "pages#how_it_works"
  match "show_video",     :to => "pages#show_video",    :as => 'show_video'
  match "powers_popup",   :to => "pages#powers_popup",  :as => 'powers_popup'
  match "natal",          :to => "pages#natal",         :as => 'natal'
  match "bank_codes",     :to => "pages#bank_codes",    :as => 'bank_codes'

  match '/deals/feed' => 'deals#feed', :as => :feed, :defaults => { :format => 'atom' }

  get 'subscribe_to_newsletter', to: 'pages#subscribe_to_newsletter', as: 'subscribe_to_newsletter'

  #TODO: Melhorar as rotas do devise:
  #http://bunwich.blogspot.com/2011/07/make-rails-devise-routes-look-better.html
  #get \"users\/show\"

  devise_for :users, :controllers => {:registrations => "registrations", :omniauth_callbacks => "omniauth_callbacks"}

  resources :users do
    resources :notifications

    member do
      get 'follow'
      get 'unfollow'
      get 'followers'
      get 'following'
      get 'sales'
      get 'friends'
      get 'withdraw'
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
