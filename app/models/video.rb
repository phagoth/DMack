class Video < ActiveRecord::Base
	belongs_to :resume
	belongs_to :user
end
