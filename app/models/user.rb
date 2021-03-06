require 'openssl'

class User < ApplicationRecord
  ITERATIONS = 20_000
  DIGEST = OpenSSL::Digest::SHA256.new
  VALIDATE_NAME = /\A\w+\z/

  attr_accessor :password
 
  has_many :questions
  has_many :questions, dependent: :destroy
  has_many :asked_questions, class_name: 'Question', foreign_key: :author_id, dependent: :nullify

  before_validation :downcase_username, :downcase_email
  before_save :encrypt_password
  validates :password, presence: true, on: :create
  validates :password, confirmation: true

  validates :email,
    presence: true,
    uniqueness: true,
    format: { with: URI::MailTo::EMAIL_REGEXP }

  validates :username,
    presence: true,
    uniqueness: true,
    length: { maximum: 40 },
    format: { with: VALIDATE_NAME }

  validates :profile_color, format: { with: /\A#\h{6}\z/ }

  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end

  def self.authenticate(email, password)
    user = find_by(email: email&.downcase)
    return nil unless user.present?

    hashed_password = User.hash_to_string(
      OpenSSL::PKCS5.pbkdf2_hmac(
        password, user.password_salt, ITERATIONS, DIGEST.length, DIGEST
      )
    )
    return user if user.password_hash == hashed_password

    nil
  end

  private

  def downcase_username
    username&.downcase!
  end

  def downcase_email
    email&.downcase!
  end  

  def encrypt_password
    if password.present?
      self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))

      self.password_hash = User.hash_to_string(
        OpenSSL::PKCS5.pbkdf2_hmac(
          password, password_salt, ITERATIONS, DIGEST.length, DIGEST
        )
      )
    end
  end
end
