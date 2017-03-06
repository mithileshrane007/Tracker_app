class Api::V1::CheckoutsController < ApplicationController
	def create
		latitude= params[:latitude]
		longitude= params[:longitude]
		target_id= params[:target_id] 
		description= params[:description]
		created_at= DateTime.now  
	    data1 ={}
		       	if latitude.present? && longitude.present? && created_at.present? && target_id.present? && description.present?
					checkout= Checkout.new(latitude: latitude,longitude: longitude,target_id: target_id,description: description,created_at: created_at)
					checkout.save
	                puts checkout.errors.inspect
					if checkout.save
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
end
