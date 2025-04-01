class Lesson < ApplicationRecord
  belongs_to :course
  has_many :topics, through: :lesson_topics
  has_many :lesson_topics
end
