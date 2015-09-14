require File.expand_path('../boot', __FILE__)

# autoload initalizers
Dir['./config/initializers/**/*.rb'].map { |file| require file }

# autoload app
relative_load_paths = Dir.glob 'app/**/*/'
ActiveSupport::Dependencies.autoload_paths += relative_load_paths

module Echo
  class Application < Gris::Application
    # config.use_health_middleware = false

    def self.instance(*)
      super(config)
    end
  end
end
