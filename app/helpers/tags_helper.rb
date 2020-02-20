module TagsHelper
  def get_tag_ranking
    Tag.joins(:items).group(:name).order('count_name desc').count(:name).first(10)
  end
end
