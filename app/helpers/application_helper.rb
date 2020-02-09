module ApplicationHelper
  def convert_to_trophy(rank)
    case rank
    when 1
      icon('fa', 'trophy', class: 'contribution-ranking__trophy--gold')
    when 2
      icon('fa', 'trophy', class: 'contribution-ranking__trophy--silver')
    when 3
      icon('fa', 'trophy', class: 'contribution-ranking__trophy--bronze')
    else
      rank
    end
  end
end
