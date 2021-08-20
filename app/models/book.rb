class Book < ApplicationRecord
	#アソシエーション
	belongs_to :user
	has_many :post_comments, dependent: :destroy

	#バリデーション
	validates :title, presence: true
  validates :body, presence: true,length: {maximum: 200}
end
