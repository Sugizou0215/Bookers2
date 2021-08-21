class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :post_comments, dependent: :destroy
  has_many :books, dependent: :destroy
  attachment :profile_image
  has_many :favorites, dependent: :destroy
  
  has_many :relationships
  has_many :followings, through: :relationships, source: :followed_id
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follower_id'
  has_many :followers, through: :reverse_of_relationships, source: :follower_id

	#バリデーション
	validates :name, length: {in: 2..20}, uniqueness: true
	validates :introduction, length: {maximum: 50}
end
