class MovieSerializer < CustomSerializer
    attributes :id, :title, :release_date, :image

    belongs_to :studio, serializer: StudiosSerializer
    has_many :characters
  end