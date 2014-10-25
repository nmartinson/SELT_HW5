class ApplicationController < ActionController::Base
  protect_from_forgery
  require 'themoviedb'
  before_filter :set_config
  Tmdb::Api.key("f4702b08c0ac6ea5b51425788bb26562")

  def set_config
    @configuration = Tmdb::Configuration.new
  end
end
