class Book < ApplicationRecord
	#アソシエーション
	belongs_to :user
	has_many :post_comments, dependent: :destroy
	has_many :favorites, dependent: :destroy

	#投稿日取得
	scope :created_today, -> { where(created_at: Time.zone.now.all_day) } # 今日
	scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) } # 前日
	scope :created_thisweek, -> { where(created_at: 6.day.ago.beginning_of_day..Time.zone.now.end_of_day) } # 今週
  scope :created_lastweek, -> { where(created_at: 2.week.ago.beginning_of_day..1.week.ago.end_of_day) } # 先週

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

	#バリデーション
	validates :title, presence: true
  validates :body, presence: true,length: {maximum: 200}
end
