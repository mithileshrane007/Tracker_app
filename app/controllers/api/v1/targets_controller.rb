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
		        	data ={}
		       		data['error'] = 'true'
			       	data['msg'] = 'Entry unsuccessful.Blank Params.'
			    end
			rescue Exception => e
				data ={}
				    data['error'] = 'true'
			       	data['msg'] = 'Authentication Failure'
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
							data1['is_online'] = i.is_online
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
 	    	begin	    		
 	    		o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
	      	    	random = (0...50).map { o[rand(o.length)] }.join

					tracking = params[:tracking_id]
					target = Target.find_by_tracking_id(tracking)
                    target.auth_token = random
                    target.save
					puts "*********************"
					puts target

		 			data1 ={}
		 			data1['error'] = 'false'
		            data1['msg'] = 'success'
		            data1['result'] = {}
		            data1['result']['target_id'] = 		    target.id
					data1['result']['first_name'] =			target.first_name
					data1['result']['last_name'] = 			target.last_name
					data1['result']['tracking_id'] = 		target.tracking_id
					data1['result']['image'] = 				target.image
					data1['result']['phone_no'] = 			target.phone_no
					data1['result']['email'] = 				target.email
					data1['result']['track_time_interval'] =target.track_time_interval
					data1['result']['track_time_out'] = 	target.track_time_out
					data1['result']['auth_token'] = 		target.auth_token
			rescue Exception => e
				data1 ={}
				data1['error'] = 'true'
				data1['msg'] = 'unsuccess'
			end	
				
				respond_to do |format|
		    		format.json { render json: data1 }
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

 	    def logout
 	    	begin
 	    		token = request.headers["token"]
 	    		is_online = params[:is_online]
 	    		target = Target.find_by_auth_token(token).id
 	    		if is_online=='true'
 	    			tar = Target.find(target)

 	    			puts "999999999999999999999999999999"
 	    			puts tar
 	    			tar.is_online = 'true'
 	    			tar.save
 	    			data1 ={}
		 			data1['error'] = 'false'
		            data1['msg'] = 'success'
				else
					is_online=='false'
					tar = Target.find(target)
 	    			tar.is_online = 'false'
 	    			tar.save
 	    			data1 ={}
		 			data1['error'] = 'false'
		            data1['msg'] = 'success'
 	    		end

 	    	rescue Exception => e
 	    		data1 ={}
				data1['error'] = 'true'
				data1['msg'] = 'unsuccess'
 	    	end
 	    	    respond_to do |format|
		    		format.json { render json: data1 }
	        	end

 	    end

 	  
  	  	def log_hour
			token = request.headers["token"]
		    targetObj = Target.find_by_auth_token(token)
		    if targetObj
		    	target = targetObj.id
		    end	
		    date = params[:date]
		    time = params[:time]
		    target_id = params[:target_id]
		    is_start = params[:is_start]
		    is_stop = params[:is_stop]
		    time_zone = params[:time_zone]

		    data = {}
				
			if target and date.present? and time.present?  and time_zone.present?
				if is_start == "true"
					daylog = DayLog.find_by_target_id_and_date(target,date)
					puts daylog.inspect

					if daylog.blank?
						daylog= DayLog.new(target_id: target,date: date,start_time: time,time_zone: time_zone)
						daylog.save
						# puts daylog.inspect
						data['error'] = false
						data['loggedhour'] = daylog.log_hour
						data['msg'] = 'success'
					else
						daylog= DayLog.new(target_id: target,date: date,start_time: time,time_zone: time_zone)

						daylog.save
						 
						puts daylog.inspect	
						data['error'] = false
						data['loggedhour'] = daylog.log_hour
						data['msg'] = 'success'				
					end  				

				elsif is_stop == "true"
					logs = DayLog.where("target_id = ? and date = ?",target,date).order('start_time desc')
					
	            log = logs.first
	            # puts "before"
	            # puts log.inspect
	            log.end_time = time		 	            
	            log.save		           
	            logs = DayLog.where("target_id = ? and date = ?",target,date).order('start_time desc')
	            log = logs.first
	            # puts "middle"
	            # puts log.inspect
	            seconds = (log.end_time - log.start_time).to_i
	            # puts "seconds"
	            # puts seconds
	            # seconds = 1200
	            actual_val = [seconds / 3600, seconds / 60 % 60, seconds % 60].map { |t| t.to_s.rjust(2,'0') }.join(':')
	            # puts "actual_val"
	            # puts actual_val
	            log.log_hour = actual_val
	            log.save
				# puts "aft/er"
	            # puts log.inspect
	            data['error'] = false
	            data['loggedhour'] = log.log_hour.strftime("%H:%M:%S")
					data['msg'] = 'success'
				else
					data['error'] = 'true'
	   			data['msg'] = 'Unsuccess invalid params.'				
				end

			else	
			
			data['error'] = 'true'
	   		data['msg'] = 'unsuccess unauthorized request.'  
			
			end

			respond_to do |format|
				format.json { render json: data }
			end
		end

end
