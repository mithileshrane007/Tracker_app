class Api::V1::LogsController < ApplicationController
		# def create
		# 	latitude= params[:latitude]
		# 	longitude= params[:longitude]
		# 	target_id= params[:target_id] 
		# 	created_at= DateTime.now  
	 #        data1 ={}
		#        	if latitude.present? && longitude.present? && created_at.present? && target_id.present?
		# 			log= Log.new(latitude: latitude,longitude: longitude,target_id: target_id,created_at: created_at)
		# 			log.save
	 #                puts  log.errors.inspect
		# 			if log.save
	 #                    render json: {error: 'false' , msg: 'Created Successfully'}
	 #                else
	 #                    render json: {error: 'true' , msg: 'process not completed'}
	 #                end
		# 		else
		# 			data1['error'] = '1002'
	 #            	data1['msg'] = 'Entry unsuccessful.Blank Params.'
	 #                respond_to do |format|
	 #                    format.json { render json: data1 }
		# 		    end
		# 		end
		# end

		# def show
 	    		
 	#     		target_id =params[:target_id]
 	#     		log = Log.where(:target_id => target_id)
 	#     			puts log
 	#     			if not log.blank?
 	#     				@log1 =[]
		# 				x=0
 	#     				for i in log
		# 					data1 ={}
		# 					data1['target_id'] =i.target_id
		# 					data1['latitude'] =i.latitude
		# 					data1['longitude'] = i.longitude
		# 					data1['created_at'] = i.created_at
							
	 # 	    			@log1.push(data1)
		# 		        x=x+1
		# 		      	end
		# 		      	 	data ={}
		# 				  	data['msg'] = 'success'
		# 				  	data['result'] = @log1

		# 	      	else
		# 		      	data ={}
		# 				data['msg'] = 'Sorry no result found'
		# 	      	end
		# 		      	respond_to do |format|
		#       				format.json { render json: data }
		#     			end	


		# end

		# def tracking
		# 	start_date = params[:start_date]
		# 	end_date = params[:end_date]
		# 	target_id = params[:target_id]
		# 	log = Log.select('DATE(created_at)').where(['target_id = ? AND DATE(created_at) BETWEEN ? AND ? ', target_id, start_date,end_date]).group("DATE(created_at)")
		# 	puts "***********************************"
		# 	 puts log
		# 			if not log.blank?
 	#     				@log1 =[]
		# 				x=0
 	#     				for i in log
		# 					data1 ={}
		# 					data1[created_at]= i.created_at
		# 				@log1.push(data1)
		# 		        x=x+1
		# 		      	end
		# 		      	data ={}
		# 				  	data['msg'] = 'success'
		# 				  	data['result'] = @log1

		# 	      	else
		# 		      	data ={}
		# 				data['msg'] = 'Sorry no result found'
		# 	      	end
		# 		      	respond_to do |format|
		#       				format.json { render json: data }
		#     			end	
		# end

		def log_create
			# begin
				token = request.headers["token"]
				target = Target.find_by_auth_token(token).id
				target_id = params[:target_id]
				
				data = JSON.parse(params[:data])
				for i in data
					log= Log.new(latitude: i['latitude'],longitude: i['longitude'],created_at: i['created_at'],time_zone: i['time_zone'],target_id: target)
						log.save
		                puts  log.errors.inspect
						data1 ={}
						data1['error'] = 'false'
				        data1['msg'] = 'success'
				end	
			# rescue Exception => e
					 #    data1 ={}
						# data1['error'] = 'true'
				  #       data1['msg'] = 'Authentication Failure'
			# end	
				
				respond_to do |format|
	  				format.json { render json: data1 }
				end
		end
			

end
