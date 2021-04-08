class Question < ApplicationRecord
  belongs_to :user

  validates :text, :text, presence: true



end
