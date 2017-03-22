class Api::V1::UsersController < ApplicationController
		def create
			begin
				email    = params[:email]
				phone_no = params[:phone_no]
				organisation_name= params[:organisation_name]
		        data1 ={}
		        o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
	      	    random = (0...50).map { o[rand(o.length)] }.join
	      	    
			       	if email.present? && phone_no.present? 
						user = User.new(email: email,phone_no: phone_no,organisation_name: organisation_name,auth_token: random)
						user.password_digest = BCrypt::Password.create(params[:password])
							user.save
							data ={}
							data['error'] = 'false'
		            		data['msg'] = 'success'
							data['result'] = {}
							data['result']['email'] = user.email
							data['result']['phone_no'] = user.phone_no
							data['result']['organisation_name'] = user.organisation_name
							data['result']['auth_token'] = user.auth_token
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

 		def login
 			begin
	 			email = params[:email]
	    		password = params[:password]

	    		puts password
	    		o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
	      	    random = (0...50).map { o[rand(o.length)] }.join

	    		user = User.find_by_email(email)
  				
  				puts "******************"
  				puts user
			    if user and user.is_verified == true
				   if user && user.authenticate(params[:password])

				        user = User.find(user.id)
				        user.auth_token = random
				        user.save
				        data={}
						data['error'] = 'false'
		            	data['msg'] = 'success'
						data['result'] = {}
						data['result']['id'] = user.id
						data['result']['email'] = user.email
						data['result']['phone_no'] = user.phone_no
						data['result']['organisation_name'] = user.organisation_name
						data['result']['auth_token'] = user.auth_token
				     else
				    	data ={}
				    	data['error'] = 'true'
				        data['msg'] = "Invalid email/password combination"
				    end
			    else
			    	data ={}
			    	data['error'] = 'true'
			       	data['msg'] = "Invalid email/password combination"
			        
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




		def getLogsForSpecificDates
 	  		token = request.headers["token"]
            user = User.find_by_auth_token(token).id
            start_date = params[:start_date]
            end_date = params[:end_date]
            target = Target.find_by_tracking_id(params[:tracking_id])           

            arrayObj = []
            data={}
            if  target && user
            	target_user_id = target.id
				puts "-----------+++++++++++++++++++++++--------------"
		        puts target_user_id

             	if start_date.present? && end_date.present?
             		date_log = DayLog.where("date >= ? AND date < ? and target_id = ?",start_date,end_date,target_user_id).order('date desc')
             		puts date_log
             		puts "-----------------------"
             		puts date_log.inspect
             		if date_log.count>0
             			x = 0
             			for i in date_log
             				puts x+1
	             			object = {}
	             			object['date'] = i.date
	             			object['log_hour'] = i.log_hour
	             			arrayObj.push(object)		             			
	             		end
					data['error'] = false
	             	data['result'] = arrayObj	
	             	data['msg'] = "Success"
	             	else
	             		tempObj={}
	             		tempObj['date'] = -1
	             		tempObj['log_hour'] = -1
	             		arrayObj.push(tempObj)
	             		puts "-1111111111111111-"
             			data['error'] = false
             			data['result'] = arrayObj	             			
             			data['msg'] = "No user with logs found."
	             	end
             	else
             		data['error']=true
             		data['msg']="Parameter invalid or incomplete."	
             	end

            else
             	data['error']=true
             	data['msg']="Invalid Authentication or unauthorized request."

            end


         
			respond_to do |format|
      			format.json { render json: data }
    		end	

	  	end



	  	def logsCoodrinateWithOnlineStatus
	  		token = request.headers["token"]
            userObj = User.find_by_auth_token(token)
            if userObj
            	user=userObj.id
            end
            date = params[:date]
            target = Target.find_by_tracking_id(params[:tracking_id]) 
            data = {}
            arrayObj = []
            if user && target
            	target_id = target.id
            	if date.present?
            			logs = Log.where("target_id = ? and CAST(created_at AS DATE) = ?",target_id,date)
            			# puts logs.inspect
		            	if logs.count > 0
		            		puts "in if"
		            		for i in logs
		            			puts "in for"

			            		object = {}
			         			object['latitude'] = i.latitude
			         			object['longitude'] = i.longitude
			         			date_and_time = '%Y-%m-%d %H:%M:%S %Z'
								# object['check'] = DateTime.strptime("2017-03-21 07:01:42 Asia/Kolkata",date_and_time).strftime("%I:%M %P")
			         			# puts TimeZone[i.time_zone].parse(i.created_at).strftime("%I:%M %P").to_s
			         			# object['time'] = i.created_at.strftime("%I:%M %P")
			         			object['time'] = i.created_at.localtime.strftime("%I:%M %P")
			         			arrayObj.push(object)	         			
		         			end	
		         			data['error']=false
			            	data['msg']="Success."
			            	data['result'] = arrayObj
		         		else
		         			data['error']=false
			            	data['msg']="No logs found for user."
			            	data['result'] = arrayObj		        
		            	end
            	else
            		data['error']=true
             		data['msg']="Parameter invalid or incomplete."            		
            	end                      	
            	
            else	
            	data['error']=true
             	data['msg']="Invalid Authentication or unauthorized request."
            end

            respond_to do |format|
      			format.json { render json: data }
    		end	
	  		
	  	end

end

