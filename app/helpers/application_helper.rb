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

  def is_mine?(object)
    # 未ログイン状態でも呼ばれるため、lonely-operatorを使用する
    object.user_id == current_user&.id
  end

  def markdown(text)
    render_options = {
        filter_html: false,
        hard_wrap: true
    }
    # renderer = Redcarpet::Render::HTML.new(render_options)
    renderer = Redcarpet::Render::CustomMarkdownRenderer.new(render_options)
    extensions = {
        autolink: true,
        fenced_code_blocks: true,
        lax_spacing: true,
        no_intra_emphasis: true,
        strikethrough: true,
        superscript: true,
        tables: true,
    }
    Redcarpet::Markdown.new(renderer, extensions).render(text).html_safe
  end

  def plain_layout?
    "#{controller_path}##{action_name}".in?(%w(sessions#new sessions#create users#new users#create))
  end
end
