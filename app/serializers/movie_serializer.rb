class MovieSerializer < ActiveModel::Serializer
    attributes :id, :title, :release_date

    belongs_to :studio
  end