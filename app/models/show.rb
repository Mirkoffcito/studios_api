class Show < ApplicationRecord
  has_many :roles
  has_many :characters, through: :roles
end
