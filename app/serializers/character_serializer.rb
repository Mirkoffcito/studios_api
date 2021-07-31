class CharacterSerializer < CustomSerializer
  attributes :id, :name, :age, :weight, :history, :image

  has_many :movies
  has_many :shows

  def weight
    "#{object.weight} kg"
  end
end
