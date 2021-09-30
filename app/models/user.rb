class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :profile_image
  has_many :plans
  has_many :group_users
  has_many :groups, through: :group_users

  validates :name, presence: true, length: {minimum: 2, maximum: 20}, uniqueness: true
  validates :introduction, length: {maximum: 50}
  # validates :color, presence: true
end
