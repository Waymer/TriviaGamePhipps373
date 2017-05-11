class GameRecord < ActiveRecord::Base
	#Relationships
	has_many :question_scores

	#Methods

	#Returns total score for given game record
	def get_total_score
		question_scores = QuestionScore.for_game_record(self.id)
		score = 0
		question_scores.length.times do |i|
			score += question_scores[i].score
		end
		score
	end
	
	#Returns total time for given game record
	def get_total_time
		question_scores = QuestionScore.for_game_record(self.id)
		time = 0
		question_scores.length.times do |i|
			time += question_scores[i].time
		end
		time
	end
end
