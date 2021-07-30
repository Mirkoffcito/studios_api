class StudioSerializer < CustomSerializer
  attributes :id, :name, :image

  has_many :movies
  has_many :shows
  
end
  