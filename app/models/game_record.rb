class GameRecord < ActiveRecord::Base
	#Relationships
	has_many :question_scores
	#Scopes

	#Validations
	#validates_presence_of :name
	#Methods
	def get_total_score
		question_scores = QuestionScore.for_game_record(self.id)
		score = 0
		question_scores.length.times do |i|
			score += question_scores[i].score
		end
		score
	end
	def get_total_time
		question_scores = QuestionScore.for_game_record(self.id)
		time = 0
		question_scores.length.times do |i|
			time += question_scores[i].time
		end
		time
	end
	def is_complete?
		#now, should be done based on number of existing question_scores

		 # related_question_scores_id = get_record_score_ids
		 # related_question_scores_id.length.times do |j|
		 # 	if (Question_score.for_specific(related_question_scores_id[j]).visited == false)
		 # 		return false
		 # 	end
		 # end
		 # return true
	end
end
