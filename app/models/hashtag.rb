class Hashtag < ApplicationRecord
  HASHTAG_REGEXP = /#[[:word:]-]+/

  has_many :hashtag_questions, dependent: :destroy
  has_many :questions, through: :hashtag_questions

  validates :name, presence: true
  scope :with_questions, -> { joins(:questions).distinct }
end
