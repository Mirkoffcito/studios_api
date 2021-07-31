class Movie < ApplicationRecord
  belongs_to :studio

  has_many :movieRoles, dependent: :destroy
  has_many :characters, through: :movieRoles

  has_one_attached :image

  scope :by_title, -> (title) { where("LOWER(title) LIKE ?", "%"+title.downcase+"%") }
  scope :by_releasedate, -> (from, to) { where("release_date >= ? AND release_date <= ?", from, to) }
end
