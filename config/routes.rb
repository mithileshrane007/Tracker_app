Rails.application.routes.draw do
namespace :api do
        namespace :v1 do

            post 'create_users', to: 'users#create'
            post 'users/show', to: 'users#show'
            post 'users/update', to: 'users#update'
            post 'targets/show', to: 'targets#show'
            post 'logs/show', to: 'logs#show'
            post 'logs/tracking', to: 'logs#tracking'
            resources :targets
            resources :users
            resources :logs 
            resources :checkouts
        end
    end
end
