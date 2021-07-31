class Show < ApplicationRecord
  belongs_to :studio

  has_many :showRoles, dependent: :destroy
  has_many :characters, through: :showRoles

  has_one_attached :image

  scope :by_title, -> (title) { where("LOWER(title) LIKE ?", "%"+title.downcase+"%") }
  scope :by_releasedate, -> (from, to) { where("release_date >= ? AND release_date <= ?", from, to) }
  scope :by_seasons, -> (number) { where("seasons = ?", number) }
end
