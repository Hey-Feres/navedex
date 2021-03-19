# frozen_string_literal: true

#
# Routes for the Application
Rails.application.routes.draw do
  #
  # Authentication
  mount_devise_token_auth_for 'User', at: 'api/v1/auth'

  #
  # API
  namespace :api, defaults: { format: 'json' } do
    #
    # Version 1
    namespace :v1 do
      #
      # Resources
      resources :navers
      resources :projects
    end
  end
end
