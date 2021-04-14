class Question < ActiveRecord
  belongs_to :user

  validates :user, :text, presence: true
end
