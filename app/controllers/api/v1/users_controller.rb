class Api::V1::UsersController < ApplicationController
		def create
			begin
				email    = params[:email]
				password = params[:password]
				phone_no = params[:phone_no]
				organisation_name= params[:organisation_name]
		        data1 ={}
		        o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
	      	    random = (0...50).map { o[rand(o.length)] }.join

			       	if email.present? && password.present? && phone_no.present? 
						user= User.new(email: email,password: password,phone_no: phone_no,organisation_name: organisation_name,auth_token: random)
							user.save
							data ={}
							data['error'] = 'false'
		            		data['msg'] = 'success'
							data['result'] = {}
							data['result']['email'] = user.email
							data['result']['phone_no'] = user.phone_no
							data['result']['organisation_name'] = user.organisation_name
					else
						data ={}
						data['error'] = '1002'
		            	data['msg'] = 'Entry unsuccessful.Blank Params.'
		            end
			rescue Exception => e
					data ={}
					data['error'] = '1003'
		            data['msg'] = 'something went wrong'
			end	
					respond_to do |format|
		                format.json { render json: data }
					    end
					
 		end

 		def show
	 		begin
	 			
	 			
		 			token = request.headers["token"]
	                puts "88888888888//////////////888888888888888888"
	                puts token
	                user = User.find_by_auth_token(token)
					puts user
	                puts user.errors.inspect
		 			data ={}
		 			data['result'] = {}
					data['result']['email'] = user.email
					data['result']['phone_no'] = user.phone_no
					data['result']['organisation_name'] = user.organisation_name
					data['result']['user_id'] = user.id

			rescue Exception => e
				data ={}
				data['error'] = 'true'
				data['msg'] = 'Token param is blank/Did not match'
			end	
				
				respond_to do |format|
		    		format.json { render json: data }
	        	end
	
 	    	end

 	    def update
    		begin
 	    		token = request.headers["token"]
	                puts "88888888888//////////////888888888888888888"
	                puts token
	                user = User.find_by_auth_token(token)
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
        	
        	user_id = params[:user_id]
	        user = User.find(user_id)
	                
	        if user.destroy
	            render json: {error: 'false', status: 'successful'}
	        else
	            render json: {error: 'true', msg: 'process not completed'}
	        end
    	end
end

