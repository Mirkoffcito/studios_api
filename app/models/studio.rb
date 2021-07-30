class Studio < ApplicationRecord
  has_many :movies, dependent: :destroy
  has_many :shows, dependent: :destroy

  has_one_attached :image

  validates :name, presence: true, allow_blank: false
end
