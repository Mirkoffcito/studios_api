class MovieSerializer < ActiveModel::Serializer
    attributes :id, :title, :release_date

    belongs_to :studio, serializer: StudiosSerializer
    has_many :characters
  end