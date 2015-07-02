require File.expand_path('../boot', __FILE__)

# autoload initalizers
Dir['./config/initializers/**/*.rb'].map { |file| require file }

# autoload app
relative_file_paths = %w(app/models app/models/concerns app/api app/api/v1/endpoints app/api/v1/presenters app/api/v2/endpoints app/api/v2/presenters)
ActiveSupport::Dependencies.autoload_paths += relative_file_paths

module Echo
  class Application < Gris::Application
    # config.use_health_middleware = false

    def self.instance(*)
      super(config)
    end
  end
end
