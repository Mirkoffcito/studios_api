class CharacterSerializer < ActiveModel::Serializer
  attributes :id, :age, :weight, :history

  has_many :movies
  has_many :shows
end
