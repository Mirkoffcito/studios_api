class ShowRole < ApplicationRecord
  belongs_to :show
  belongs_to :character

  scope :by_name, -> (name) { joins(:character).where("character.name LIKE ?", name) }
end
