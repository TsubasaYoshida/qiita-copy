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
end
