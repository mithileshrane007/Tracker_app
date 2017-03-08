Rails.application.routes.draw do
namespace :api do
        namespace :v1 do

            post 'create_users', to: 'users#create'
            post 'users_show', to: 'users#show'
            post 'users_update', to: 'users#update'
            post 'users_delete', to: 'users#destroy'
            post 'create_targets', to: 'targets#create'
            post 'targets_show', to: 'targets#show'
            post 'targets_update', to: 'targets#update'
            post 'targets_delete', to: 'targets#destroy'
            post 'logs/show', to: 'logs#show'
            post 'logs/tracking', to: 'logs#tracking'
            resources :targets
            resources :users
            resources :logs 
            resources :checkouts
        end
    end
end
