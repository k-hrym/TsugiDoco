require_relative 'boot'

require 'rails/all'
require 'csv'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TsugiDoco
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    # エラーメッセージの日本語化
    config.i18n.default_locale = :ja
    # libファイルを参照(VisionAPIを採用する際に追記)
    config.paths.add 'lib', eager_load: true
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.time_zone = 'Asia/Tokyo'

    # エラーメッセージの個別化
    config.action_view.field_error_proc = Proc.new do |html_tag, instance|
      # エラーが出てない場合
      if instance.kind_of?(ActionView::Helpers::Tags::Label)
        html_tag.html_safe  #HTMLをそのまま表示する
      else
      # エラーの場合
        # オブジェクトのクラスネームの小文字化
        class_name = instance.object.class.name.underscore
        # メソッド名
        method_name = instance.instance_variable_get(:@method_name)
        # エラーメッセージ部分のHTML
        # I18~のところがエラーになった要素
        # instance~のところがメッセージの動詞部分
        # html_tagが元のHTML
        "<div class=\"has-error\">
          #{html_tag}
          <div class=\"help-block\">
            #{I18n.t("activerecord.attributes.#{class_name}.#{method_name}")}
            #{instance.error_message.first}
          </div>
        </div>".html_safe
      end
    end
  end
end
