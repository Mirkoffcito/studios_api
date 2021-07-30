class CustomSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  def image
    rails_blob_url(object.image, only_path: false) if object.image.attached?
  end
end