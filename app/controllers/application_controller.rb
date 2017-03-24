class ApplicationController < ActionController::Base

   protect_from_forgery with: :exception 
    protect_from_forgery with: :null_session, :if => Proc.new { |c| c.request.format == 'application/json' }
    
def verify_token
        
        if params[:token].present?
            user = User.where('auth_token = ?', params[:token]).first
            if user.present?
                return session[:user_id] = user.id
            else
                render json: {error: 'Authentication error. Authentication token is not recognized'}
            end
        else
            render json: {error: 'Authentication error. Authentication token is necessary'} 
        end
    end
end
