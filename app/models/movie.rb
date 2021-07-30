class Movie < ApplicationRecord
  belongs_to :studio

  has_many :movieRoles, dependent: :destroy
  has_many :characters, through: :movieRoles

  has_one_attached :image
end
