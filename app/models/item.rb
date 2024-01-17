class Item < ApplicationRecord
  belongs_to :user
  mount_uploader :image, ImageUploader
  # バリデーション
  validates :title, presence: true, length: { maximum: 32 }
  validates :detail, presence: true, length: { maximum: 140 }
end
