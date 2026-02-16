class Event < ApplicationRecord
    enum event_type: { vod: 0, live: 1, adv: 2 }

    def self.generate_events(start_time, end_time, videos)
        start_time = start_time.to_datetime
        end_time = end_time.to_datetime

        while start_time < end_time
            video = videos.sample
            Event.create(name: video.title, start_time: start_time, videos_id: video.id)
            start_time += video.length.seconds
        end
    end
    
end
