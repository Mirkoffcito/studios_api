class Show < ApplicationRecord
  belongs_to :studio

  has_many :roles
  has_many :characters, through: :roles

  has_one_attached :image
end
