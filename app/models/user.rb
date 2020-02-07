class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :confirmable, # removed registerable
         :recoverable, :rememberable, :validatable

  # Reference to Article model
  has_many :articles, dependent: :destroy

  # before_save { self.email = email.downcase }
  # VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  # validates :email, presence: true, uniqueness: {case_sensitive: false},
  #           length: {minimum: 3},
  #           format: {with: VALID_EMAIL_REGEX}
  # validates :password, presence: true
  validates :username, presence: true, uniqueness: {case_sensitive: false},
            length: {minimum: 3}

  # Has one profile photo attached
  has_one_attached :avatar
end
