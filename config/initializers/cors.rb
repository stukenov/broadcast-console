Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins 'http://localhost:3000', 'http://localhost:8001'
      resource '*',
        headers: :any,
        methods: [:get, :post, :put, :delete, :options, :head],
        credentials: true # Include cookies with requests
    end
end
