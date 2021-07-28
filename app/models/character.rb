class Character < ApplicationRecord
  has_many :roles
  has_many :movies, through: :roles

  has_one_attached :image
end
