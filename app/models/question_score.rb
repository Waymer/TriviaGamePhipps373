class QuestionScore < ActiveRecord::Base
	#Relationships
	has_many :record_scores

	#Scopes
	scope :for_specific, ->(qs_id) { where('qs_id = ?', qs_id) }
	#Validations
	validates_presence_of :qs_id
	validates_presence_of :score
	validates_presence_of :visited
	#not sure whether or not to include these last two, could depend on front end implementation
	validates_presence_of :landmark_id
	validates_presence_of :question_id
	#Methods
end
