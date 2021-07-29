class Character < ApplicationRecord
  has_many :movieRoles
  has_many :movies, through: :movieRoles

  has_many :showRoles
  has_many :shows, through: :showRoles

  has_one_attached :image
end
