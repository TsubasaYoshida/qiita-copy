require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module QiitaCopy
  class Application < Rails::Application
    config.paths.add 'lib', eager_load: true

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local

    config.i18n.default_locale = :ja

    config.generators do |g|
      g.assets false
      g.helper false
      g.jbuilder false
      g.test_framework :rspec,
                       # テストデータベースにレコードを作成するファイルの作成をスキップ
                       fixtures: false,
                       # ビュースペックの作成をスキップ(UIのテストはフィーチャスペックに任せる)
                       view_specs: false,
                       # ヘルパースペックの作成をスキップ
                       helper_specs: false,
                       # ルーティングスペックの作成をスキップ
                       routing_specs: false,
                       # コントローラースペックの作成をスキップ
                       controller_specs: false,
                       # リクエストスペックの作成をスキップ
                       request_specs: false

    end
  end
end
