class User < ActiveRecord::Base
	has_many :targets, foreign_key: "user_id" 
	has_secure_password
	has_attached_file :image
    do_not_validate_attachment_file_type :image
    
end

