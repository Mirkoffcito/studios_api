class Movie < ApplicationRecord
  has_many :roles
  has_many :characters, through: :roles

  has_one_attached :image
end
