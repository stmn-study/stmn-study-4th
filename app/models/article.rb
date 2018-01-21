class Article < ApplicationRecord
  has_many_attached :images

  class << self
    def image_tag_regex
      /\[article_image:([a-zA-Z0-9-]+)\]/
    end
  end

  def create_attachments
    temp_blobs.each do |temp_blob|
      images.create!(blob: temp_blob)
    end
  end

  def temp_blobs
    image_tags.map {|signed_id| ActiveStorage::Blob.find_signed(signed_id)}
  end

  private
  def image_tags
    body.scan(self.class.image_tag_regex)
  end
end
