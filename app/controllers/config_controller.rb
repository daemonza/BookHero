require 'yaml'

class ConfigController < ApplicationController

  # Get the current settings values
  def settings
  	
  	# Get the currently set path
  	config_file = File.expand_path('../../config/bookhero.conf',File.dirname(__FILE__))
    settings = YAML::load(File.open(config_file))

  	@configured_library_path = settings['library_path']
  	@configured_google_api_key = settings['google_api_key']

  end


  # Save settings to config file
  def save
    # Get the currently set path
  	config_file = File.expand_path('../../config/bookhero.conf',File.dirname(__FILE__))
    settings = YAML::load(File.open(config_file))
  	@configured_library_path = settings['library_path']
  	@configured_google_api_key = settings['google_api_key']

    
    # Get data from form
    library_path = params[:library_path]
    if library_path.blank?
      library_path = @configured_library_path
    end

    google_api_key = params[:google_api_key]
    # if google_api_key.blank?
    #   google_api_key = @configured_google_api_key 
    # end

    # Write the data to yaml config file.
  	data = {"library_path" => "#{library_path}",
            "google_api_key" => "#{google_api_key}"}
  	File.open(File.expand_path('../../config/bookhero.conf',File.dirname(__FILE__)),"w") {|f| f.write(data.to_yaml)}

    # Read settings again
    redirect_to :action => "settings"

  end

end
