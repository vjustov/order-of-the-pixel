require 'bundler/setup'
Bundler.require(:default)

require File.dirname(__FILE__) + "/app.rb"
require File.dirname(__FILE__) + "app.rb"


map "/" do
    run Base
end