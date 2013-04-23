class AuthorizedController < ApplicationController
  before_filter :authenticate_user!
  check_authorization
  load_and_authorize_resource

  before_filter :check_access_token

  def check_access_token
    # if user_signed_in? && (current_user.access_token_expires_at.blank? || current_user.access_token_expires_at <= (Time.now - 1.day))
    #   auth = FbGraph::Auth.new('146791075437937', '9bbac57de01036fefc93a09b45a598d9')
    #   auth.exchange_token! current_user.access_token # Needs fb_graph 2.3.1+
    #   current_user.access_token = auth.access_token # => new token

    #   # app = FbGraph::Application.new('146791075437937', :secret => '9bbac57de01036fefc93a09b45a598d9')
    #   # result = app.debug_token current_user.access_token
    #   # result.application # => FbGraph::Application
    #   # result.user        # => FbGraph::User
    #   # result.is_valid    # => Boolean
    #   # current_user.access_token_expires_at = result.expires_at  # => Time
    #   # result.issued_at   # => Time or nil
    #   # result.scopes      # => Array of String
    #   # result.metadata    # => Hash or nil
    #   # result.error       # => Hash or nil

    #   current_user.save(validate: false)
    # end
  end
end