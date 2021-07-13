class Question < ApplicationRecord
  has_many :hashtag_questions, dependent: :destroy
  has_many :hashtags, through: :hashtag_questions

  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true

  validates :text, presence: true, length: { maximum: 255 }

  after_commit :add_hashtags, on: %i[create update]

  private

  def add_hashtags
    self.hashtags = "#{text} #{answer}".downcase.scan(Hashtag::HASHTAG_REGEXP).uniq.map do |hashtag|
      Hashtag.find_or_create_by(name: hashtag.delete("#"))
    end
  end
end
