class ShowRole < ApplicationRecord
  belongs_to :show
  belongs_to :character
end
