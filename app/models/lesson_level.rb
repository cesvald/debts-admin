class LessonLevel < ActiveRecord::Base
	has_many :lessons
	
	scope :available_levels, -> (current_level) { where( "number <= :current_level", {current_level: current_level} ).order(number: :asc) }
	
	def to_s
		name
	end

	def class_s
		name.downcase
	end
end
