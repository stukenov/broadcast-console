class ScheduleVideoPlaybackJob
  include Sidekiq::Job

  def perform(*)
    events = fetch_events
    return if events.empty?

    server = find_server
    video = find_video(events.first.videos_id)
    create_command(server, video)
  rescue StandardError => e
    log_error("ScheduleVideoPlaybackJob failed", e)
  end

  private

  def fetch_events
    Event.where(start_time: Time.current.change(nsec: 0))
  end

  def find_server
    Server.find_by(name: 'SRVLCL01VCSP03')
  end

  def find_video(video_id)
    Video.find(video_id)
  end

  def create_command(server, video)
    Command.create(
      server_id: server.id,
      target: "caspar",
      length: "short",
      command: "PLAY 1-1 #{video.file.filename}",
      status: "pending"
    )
  end

  def log_error(message, error)
    puts "#{message}: #{error.message}"
    puts error.backtrace.join("\n")
  end
end
