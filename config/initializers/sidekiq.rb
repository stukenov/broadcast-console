Sidekiq.configure_server do |config|
  config.redis = { url: ENV['REDIS_URL'] }

  config.on(:startup) do
    Rails.logger.debug "Sidekiq server starting up"
    Sidekiq::Scheduler.reload_schedule!
  end
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV['REDIS_URL'] }
end