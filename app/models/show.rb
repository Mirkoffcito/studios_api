class Show < ApplicationRecord
  belongs_to :studio

  has_many :showRoles
  has_many :characters, through: :showRoles

  has_one_attached :image
end
