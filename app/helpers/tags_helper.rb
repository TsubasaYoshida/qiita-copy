module TagsHelper
  def tag_url(tag)
    "/tags/#{tag.name}"
  end
end
