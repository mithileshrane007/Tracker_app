Rails.application.routes.draw do
namespace :api do
        namespace :v1 do
            post 'user_login', to: 'users#login'
            post 'create_users', to: 'users#create'
            post 'users_show', to: 'users#show'
            post 'users_update', to: 'users#update'
            post 'users_delete', to: 'users#destroy'
            post 'create_targets', to: 'targets#create'
            post 'targets_show', to: 'targets#show'
            post 'targets_show_targets', to: 'targets#show_targets'
            post 'targets_login', to: 'targets#target_login'
            post 'targets_update', to: 'targets#update'
            post 'targets_delete', to: 'targets#destroy'
            post 'logs/show', to: 'logs#show'
            post 'logs/tracking', to: 'logs#tracking'
            post 'logs_create', to: 'logs#log_create'
            post 'create_checkout', to: 'checkouts#create'
            post 'target_session_status', to: 'targets#logout'
            post 'logged_hours', to: 'targets#log_hour'
            post 'getLogswithDate', to: 'users#getLogsForSpecificDates'
            post 'getLogswithStatus', to: 'users#logsCoodrinateWithOnlineStatus'

            resources :targets
            resources :users
            resources :logs 
            resources :checkouts
        end
    end
end
