class Api::V1::CheckoutsController < ApplicationController
	def create
		begin	
			token = request.headers["token"]
			latitude= params[:latitude]
			longitude= params[:longitude]
			target_id= params[:target_id] 
			description= params[:description]
			tracking_id= params[:tracking_id]
			created_at= params[:created_at] 
			
		   
			       	if token.present? && latitude.present? && longitude.present? && created_at.present? && target_id.present? && description.present?
						checkout= Checkout.new(latitude: latitude,longitude: longitude,target_id: target_id,description: description,created_at: created_at)
						checkout.save
		                puts checkout.errors.inspect
						checkout.save
							data ={}
							data['error'] = 'false'
			            	data['msg'] = 'success'
							
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
end
