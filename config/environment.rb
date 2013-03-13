# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
UserAuth::Application.initialize!

#Rails::Initializer.run do |config|
#  config.gem "authlogic"
#  config.gem "declarative_authorization", :source => "http://gemcutter.org"	
#end

#config.middleware.use "PDFKit::Middleware"