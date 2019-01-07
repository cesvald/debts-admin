class Profile < ActiveRecord::Base
	has_many :roles
	has_many :users, through: :roles
	
	[:acom, :coor, :admin, :maint, :swami, :guru].each do |name|
		define_singleton_method name do
			Profile.where(name: name).first
		end
	end
end