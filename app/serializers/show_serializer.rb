class ShowSerializer < CustomSerializer
  attributes :id, :title, :release_date, :seasons, :image
  
  belongs_to :studio
  has_many :characters
end
