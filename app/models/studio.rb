class Studio < ApplicationRecord
  has_many :movies
  has_many :shows

  has_one_attached :image

  validates :name, presence: true, allow_blank: false
end
