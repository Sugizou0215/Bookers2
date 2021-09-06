class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room

  #バリデーション
  validates :content, presence: true,length: {maximum: 120}
end
