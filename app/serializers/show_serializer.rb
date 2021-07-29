class ShowSerializer < ActiveModel::Serializer
  attributes :id, :title, :release_date, :seasons
  
  belongs_to :studio
end
