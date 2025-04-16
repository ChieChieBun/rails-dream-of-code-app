class Topic < ApplicationRecord
  has_many :lessons, through: :lesson_topics
  has_many :lesson_topics
end
