# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'

run Rails.application

use Rack::Cors do
  allow do
    origins '*'
    resource '/helloword/json',
        methods: [:post]
    resource '/api/v1/login',
        methods: [:post]
    resource '/api/v1/addsetbox',
        methods: [:post]
    resource '/api/v1/logout',
        methods: [:post]
  end
end
