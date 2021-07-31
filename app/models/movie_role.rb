class MovieRole < ApplicationRecord
  belongs_to :movie
  belongs_to :character

  scope :by_name, -> (name) { joins(:character).where("character.name LIKE ?", name) }
end
