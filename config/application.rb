require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module New
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # config.middleware.use Rack::Auth::Basic, "Your Realm" do |username, password|
    #   # Replace the condition below with your own authentication logic.
    #   username == ENV['USERNAME'] && password == ENV['PASSWORD']
    # end

    # helper_method :current_user, :logged_in?

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end
  
    def logged_in?
      !current_user.nil?
    end
  
    def log_out
      session.delete(:user_id)
      @current_user = nil
    end
  end
end
