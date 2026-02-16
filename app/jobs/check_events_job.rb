require 'sidekiq-scheduler'

class CheckEventsJob
  include Sidekiq::Job

  def perform
    events = fetch_upcoming_events
    return if events.empty?

    server = find_server
    events.each { |event| process_event(event, server) }
  rescue StandardError => e
    log_error("CheckEventsJob failed", e)
  end

  private

  def fetch_upcoming_events
    Event.where(start_time: Time.current..(Time.current + 1.hour))
  end

  def find_server
    Server.find_by(name: 'SRVLCL01VCSP03')
  end

  def process_event(event, server)
    video = find_video(event.videos_id)
    if video_stored?(video)
      log_info("Video already stored", video.id)
    else
      log_info("Video not stored, uploading", video.id)
      upload_video(video, server)
    end
  end

  def find_video(video_id)
    Video.find(video_id)
  end

  def video_stored?(video)
    Server.exists?(id: video.stored_in_id)
  end

  def upload_video(video, server)
    command = create_command(video, server)
    sleep 10
    if command.persisted?
      video.update(stored_in_id: server.id)
    else
      log_error("Command could not be saved", command.errors.full_messages.join(', '))
    end
  rescue StandardError => e
    log_error("Upload video failed", e)
  end

  def create_command(video, server)
    Command.create(
      server_id: server.id,
      target: "download",
      length: "long",
      command: "http://localhost:3000/adapto/videos/#{video.id}/download",
      status: "pending"
    )
  end

  def log_info(message, detail)
    puts "#{message}: #{detail}"
  end

  def log_error(message, error)
    puts "#{message}: #{error.message}"
    puts error.backtrace.join("\n")
  end
end