class MovieSerializer < ActiveModel::Serializer
    attributes :id, :title, :release_date

    belongs_to :studio
    has_many :characters
  end