Apipie.configure do |config|
    config.app_name                = "Movie Review App"
    config.api_base_url            = "/api"
    config.doc_base_url            = "/apipie"
    config.api_controllers_matcher = "#{Rails.root}/app/controllers/**/*.rb"
  end
  