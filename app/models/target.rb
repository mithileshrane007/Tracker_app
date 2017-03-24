class Target < ActiveRecord::Base
	belongs_to :user
	has_many :logs, foreign_key: "target_id"
	has_attached_file :image
    do_not_validate_attachment_file_type :image
end