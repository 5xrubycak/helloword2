# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'

run Rails.application

use Rack::Cors do
  allow do
    origins '*'
            # regular expressions can be used here
    resource '/helloword/json',
        methods: [:post]
        # expose: ['Some-Custom-Response-Header'],
        # max_age: 600
        # headers to expose
  end
end
