class Character < ApplicationRecord
  has_many :movieRoles, dependent: :destroy
  has_many :movies, through: :movieRoles

  has_many :showRoles, dependent: :destroy
  has_many :shows, through: :showRoles

  has_one_attached :image
end
