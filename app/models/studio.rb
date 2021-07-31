class Studio < ApplicationRecord
  has_many :movies, dependent: :destroy
  has_many :shows, dependent: :destroy

  has_one_attached :image

  validates :name, presence: true, allow_blank: false

  scope :by_name, -> (name) { where("LOWER(name) LIKE ?", "%"+name.downcase+"%") }
end
