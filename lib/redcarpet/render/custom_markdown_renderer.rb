require 'rouge/plugins/redcarpet'

class Redcarpet::Render::CustomMarkdownRenderer < Redcarpet::Render::HTML
  include Rouge::Plugins::Redcarpet
end
