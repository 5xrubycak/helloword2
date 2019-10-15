# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'

run Rails.application

use Rack::Cors do
  allow do
    origins '*'
            # regular expressions can be used here
    resource 'https://helloword.space/helloword/json',
        methods: [:post]
        # expose: ['Some-Custom-Response-Header'],
        # max_age: 600
        # headers to expose
    resource 'https://helloword.space/helloword/api/v1/login',
        methods: [:post]
        # expose: ['Some-Custom-Response-Header'],
        # max_age: 600
        # headers to expose
    resource 'https://helloword.space/helloword/api/v1/addsetbox',
        methods: [:post]
        # expose: ['Some-Custom-Response-Header'],
        # max_age: 600
        # headers to expose
    resource 'https://helloword.space/helloword/api/v1/logout',
        methods: [:post]
        # expose: ['Some-Custom-Response-Header'],
        # max_age: 600
        # headers to expose
  end
end
