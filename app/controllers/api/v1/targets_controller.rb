class Api::V1::TargetsController < ApplicationController

	def create
		begin
			token = request.headers["token"]
	        user = User.find_by_auth_token(token).id
	        puts "**********9999999999999********************"
	        puts user
			first_name = params[:first_name]
	     	last_name = params[:last_name]
	     	phone_no = params[:phone_no]
	     	email = params[:email]
	     	track_time_interval = params[:track_time_interval]
	     	track_time_out = params[:track_time_out]
	     	random =rand.to_s[2..9]

	     	data ={}
	     	if first_name.present? && last_name.present?  && phone_no.present? && email.present?
	     		target = Target.new(first_name: first_name, last_name: last_name, phone_no: phone_no,email: email,tracking_id: random,user_id: user,track_time_interval: track_time_interval,track_time_out: track_time_out)
	     		    
 		    	if not params[:image].blank?
				  StringIO.open(Base64.decode64(params[:image])) do |data|
                    data.class.class_eval { attr_accessor :original_filename, :content_type }
                    data.original_filename = "file.jpg"
                    data.content_type = "image/jpeg"
                    target.image = data
                  end
                end
                
                target.save
                # UserMailer.welcome_email(email, random).deliver_now
              	data ={}
				data['error'] = 'false'
		        data['msg'] = 'success'

	        else
	       		data['error'] = '1002'
		       	data['msg'] = 'Entry unsuccessful.Blank Params.'
		    end
		rescue Exception => e
			    data['error'] = '1002'
		       	data['msg'] = 'Entry unsuccessful.Blank Params.'
		end
	     	
                	respond_to do |format|
                		format.json { render json: data }
                	end
    end

        def update
    		begin
    			token = request.headers["token"]
    			id = params[:id]
	        	user = User.find_by_auth_token(token).id
	    		target = Target.where(id: id, user_id: user).first

	    		puts "99955555222222222222222222222222"
	    		puts target
	    		target.first_name = params[:first_name]
	    		target.last_name = params[:last_name]
	    		target.phone_no = params[:phone_no]
	    		target.email = params[:email]
	    		target.save
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

 	    def show
 	    	    token = request.headers["token"]
 	    		tracking_id = params[:tracking_id]
 	    		user = User.find_by_auth_token(token).id
 	    		target = Target.where(user_id: user,tracking_id: tracking_id)
 	    		
 	    			puts target

 	    			if not target.blank?
 	    				@target1 =[]
						x=0
 	    				for i in target
							data1 ={}
							
							data1['first_name'] =i.first_name
							data1['last_name'] = i.last_name
							data1['tracking_id'] = i.tracking_id
							data1['image'] = i.image
							data1['phone_no'] = i.phone_no
							data1['email'] = i.email
							data1['track_time_interval'] = i.track_time_interval
							data1['track_time_out'] = i.track_time_out
							
	 	    			@target1.push(data1)
				        x=x+1
				      	end
				      	 	data ={}
				      	 	data['error'] = 'false'
						  	data['msg'] = 'success'
						  	data['result'] = @target1

			      	else
				      	data ={}
						data['error'] = 'true'
						data['msg'] = 'unsuccess'
			      	end
				      	respond_to do |format|
		      				format.json { render json: data }
		    			end	

 	    end

 	    def show_targets
 	    	    token = request.headers["token"]
 	    		user = User.find_by_auth_token(token).id
 	    		target = Target.where(user_id: user)
 	    		
 	    			puts target

 	    			if not target.blank?
 	    				@target1 =[]
						x=0
 	    				for i in target
							data1 ={}
							
							data1['first_name'] =i.first_name
							data1['last_name'] = i.last_name
							data1['tracking_id'] = i.tracking_id
							data1['image'] = i.image
							data1['phone_no'] = i.phone_no
							data1['email'] = i.email
							data1['track_time_interval'] = i.track_time_interval
							data1['track_time_out'] = i.track_time_out
	 	    			@target1.push(data1)
				        x=x+1
				      	end
				      	 	data ={}
				      	 	data['error'] = 'false'
						  	data['msg'] = 'success'
						  	data['result'] = @target1

			      	else
				      	data ={}
				      	data['error'] = 'true'
						data['msg'] = 'unsuccess'
			      	end
				      	respond_to do |format|
		      				format.json { render json: data }
		    			end	

 	    end

 	    def target_login
 	    	    
 	    		tracking_id = params[:tracking_id]
 	    		
 	    		target = Target.where(tracking_id: tracking_id)
 	    		
 	    			puts target

 	    			if not target.blank?
 	    				@target1 =[]
						x=0
 	    				for i in target
							data1 ={}
							
							data1['first_name'] =i.first_name
							data1['last_name'] = i.last_name
							data1['tracking_id'] = i.tracking_id
							data1['image'] = i.image
							data1['phone_no'] = i.phone_no
							data1['email'] = i.email
							data1['track_time_interval'] = i.track_time_interval
							data1['track_time_out'] = i.track_time_out
							
	 	    			@target1.push(data1)
				        x=x+1
				      	end
				      	 	data ={}
				      	 	data['error'] = 'false'
						  	data['msg'] = 'success'
						  	data['result'] = @target1

			      	else
				      	data ={}
				      	data['error'] = 'true'
						data['msg'] = 'unsuccess'
			      	end
				      	respond_to do |format|
		      				format.json { render json: data }
		    			end	

 	    end

 	    def destroy
 	    	token = request.headers["token"]
    		id = params[:id]
    		user = User.find_by_auth_token(token).id
 	    	@target = Target.where(id: id, user_id: user).first

 	    	puts "/////////////////////////////////"
 	    	puts @target
	        if @target.destroy
	            render json: {error: 'false', status: 'successful'}
	        else
	            render json: {error: 'true', msg: 'process not completed'}
	        end
 	    end
   
end
