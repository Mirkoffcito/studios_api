class CharacterSerializer < ActiveModel::Serializer
  attributes :id, :name, :age, :weight, :history

  has_many :movies
  has_many :shows
end
