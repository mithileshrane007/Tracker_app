class Api::V1::TargetsController < ApplicationController

	before_filter :verify_token
    
        def create
	     	first_name = params[:first_name]
	     	last_name = params[:last_name]
	     	phone_no = params[:phone_no]
	     	random =rand.to_s[2..9]
	     	
	     	data1 ={}
	     	if first_name.present? && last_name.present?  && phone_no.present? 
	     		target = Target.new(first_name: first_name, last_name: last_name, phone_no: phone_no,tracking_id: random,user_id: session[:user_id])
	     		    
 		    	if not params[:image].blank?
				  StringIO.open(Base64.decode64(params[:image])) do |data|
                    data.class.class_eval { attr_accessor :original_filename, :content_type }
                    data.original_filename = "file.jpg"
                    data.content_type = "image/jpeg"
                    target.image = data
                  end
                end
                
                target.save
              	puts "99999999999999999999999999999999999999"
              	puts  target.errors.inspect

                if target.save
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

        def update
    		begin
	    		target = Target.where(id: params[:id], user_id: session[:user_id]).first

	    		puts "99955555222222222222222222222222"
	    		puts target
	    		target.first_name = params[:first_name]
	    		target.last_name = params[:last_name]
	    		target.phone_no = params[:phone_no]
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
 	    	    tracking_id = params[:tracking_id]
 	    		user = session[:user_id]
 	    		puts user
 	    		target = Target.where(:user_id => user, tracking_id: tracking_id)
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
							
	 	    			@target1.push(data1)
				        x=x+1
				      	end
				      	 	data ={}
						  	data['msg'] = 'success'
						  	data['result'] = @target1

			      	else
				      	data ={}
						data['msg'] = 'Sorry no result found'
			      	end
				      	respond_to do |format|
		      				format.json { render json: data }
		    			end	

 	    end

 	    def destroy
 	    	@target = Target.where(id: params[:id], user_id: session[:user_id]).first

 	    	puts "/////////////////////////////////"
 	    	puts @target
	        if @target.destroy
	            render json: {error: 'false', status: 'successful'}
	        else
	            render json: {error: 'true', msg: 'process not completed'}
	        end
 	    end
   
end
