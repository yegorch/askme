class Question < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: 'User'

  validates :user, :text, presence: true
end
