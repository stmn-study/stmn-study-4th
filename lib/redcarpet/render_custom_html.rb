class RenderCustomHtml < Redcarpet::Render::HTML

  # redcarpetの処理後に呼ばれるコールバック
  def postprocess(full_document)
    replace_image!(full_document)
    full_document
  end

  private
  # [image:key]
  def replace_image!(full_document)
    full_document.gsub!(Article.image_tag_regex) do
      blob = ActiveStorage::Blob.find_signed($1)
      if blob.present?
        "<img src='#{blob.service_url}'/>"
      else
        ''
      end
    end
  end
end
