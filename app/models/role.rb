class Role < ApplicationRecord
  belongs_to :movie
  belongs_to :show
  belongs_to :character
  belongs_to :studio
end
