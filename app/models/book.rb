class Book < ApplicationRecord
	#アソシエーション
	belongs_to :user
	has_many :post_comments, dependent: :destroy
	has_many :favorites, dependent: :destroy

	#投稿日取得
	scope :created_today, -> { where(created_at: Time.zone.now.all_day) } # 今日
	scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) } # 前日
	scope :created_two_days_ago, -> { where(created_at: 2.days.ago.all_day) } # 2日前
  scope :created_three_days_ago, -> { where(created_at: 3.days.ago.all_day) } # 3日前
  scope :created_four_days_ago, -> { where(created_at: 4.days.ago.all_day) } # 4日前
  scope :created_five_days_ago, -> { where(created_at: 5.days.ago.all_day) } # 5日前
  scope :created_six_days_ago, -> { where(created_at: 6.days.ago.all_day) } # 6日前
	scope :created_thisweek, -> { where(created_at: 6.day.ago.beginning_of_day..Time.zone.now.end_of_day) } # 今週
  scope :created_lastweek, -> { where(created_at: 2.week.ago.beginning_of_day..1.week.ago.end_of_day) } # 先週

	#新着順
	scope :latest, -> {order(id: :desc)}
	scope :value, -> {order(evaluation: :desc)}

	is_impressionable counter_cashe: true

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

	#バリデーション
	validates :title, presence: true
  validates :body, presence: true,length: {maximum: 200}
end
