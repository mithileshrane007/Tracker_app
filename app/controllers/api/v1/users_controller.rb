class Api::V1::UsersController < ApplicationController
		def create
			email= params[:email]
			password= params[:password]
			phone_no= params[:phone_no]
			organisation_name= params[:organisation_name]
	        data1 ={}
	        o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
      	    random = (0...50).map { o[rand(o.length)] }.join
		       	if email.present? && password.present? && phone_no.present? 
					user= User.new(email: email,password: password,phone_no: phone_no,organisation_name: organisation_name,auth_token: random)
					user.save
	                puts  user.errors.inspect
					if user.save
	                    render json: {error: 'false' , msg: 'Created Successfully'}
	                else
	                    render json: {error: 'true' , msg: 'process not completed'}
	                end
				else
					data1['error'] = '1002'
	            	data1['msg'] = 'Entry unsuccessful.Blank Params.'
	                respond_to do |format|
	                    format.json { render json: data1 }
				    end
				end
 		end

 		def show
	 		begin
	 			user =User.find(params[:user_id])
	 			data ={}
	 			data['result'] = {}
				data['result']['email'] = user.email
				data['result']['phone_no'] = user.phone_no
				data['result']['organisation_name'] = user.organisation_name
				data['result']['user_id'] = user.id
				data['result']['auth_token'] = user.auth_token
			rescue Exception => e
				data ={}
				data['error'] = 'true'
				data['msg'] = 'something went wrong'
			end		
				respond_to do |format|
		    		format.json { render json: data }
	        	end
	
 	    	end

 	    def update
    		begin
 	    		user =User.find(params[:user_id])
 	    		user.email = params[:email]
 	    		user.password_digest = params[:password]
 	    		user.phone_no = params[:phone_no]
 	    		user.organisation_name = params[:organisation_name]
 	    		user.save
 	    		data ={}
 	    		data['error'] = 'false'
				data['msg'] = 'success'
			rescue Exception => e
					data ={}
					data['error'] = 'true'
					data['msg'] = 'something went wrong'
			end
				respond_to do |format|
	      			format.json { render json: data }
	    		end	
 	    end

 	    def destroy
        	@user = User.where(id: params[:id]).first
	        if @user.destroy
	            render json: {error: 'false', status: 'successful'}
	        else
	            render json: {error: 'true', msg: 'process not completed'}
	        end
    	end
end

