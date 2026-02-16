class VideosController < ApplicationController
  def index
    @videos = Video.all
  end

  def new
    @video = Video.new
  end

  def create
    files = Array(params.dig(:video, :files) || params.dig(:video, :file))
    titles = Array(params.dig(:video, :titles) || params.dig(:video, :title))
    durations = Array(params.dig(:video, :durations) || params.dig(:video, :duration))
    
    ActiveRecord::Base.transaction do
      if process_videos(files, titles, durations)
        redirect_to videos_path, notice: 'Videos were successfully uploaded.'
      else
        raise ActiveRecord::Rollback
      end
    end
  rescue StandardError => e
    flash.now[:alert] = "An error occurred while uploading videos: #{e.message}"
    render :new
  end

  def show
    @video = find_video
  end

  def destroy
    @video = find_video
    if @video.events.exists?
      flash[:alert] = 'There are events associated with this video. Please unlink them before deleting the video.'
      redirect_to videos_path
    else
      @video.destroy
      redirect_to videos_path, notice: 'Video was successfully deleted.'
    end
  end

  def edit
    @video = find_video
  end

  def update
    @video = find_video
    if @video.update(video_params)
      redirect_to @video, notice: 'Video was successfully updated.'
    else
      render :edit
    end
  end

  def download
    send_video(:attachment)
  end

  def play
    send_video(:inline)
  end

  private

  def video_params
    params.require(:video).permit(:title, :file)
  end

  def extract_title(filename)
    File.basename(filename, File.extname(filename))
  end

  def process_videos(files, titles, durations)
    files.each_with_index do |file, index|
      next if file.blank?

      title = titles[index].presence || extract_title(file.original_filename)
      duration = durations[index].presence || 0
      video = Video.new(title: title, file: file, duration: duration)
      unless video.save
        flash.now[:alert] = "Failed to save video: #{video.errors.full_messages.to_sentence}"
        return false
      end
    end
    true
  end

  def find_video
    Video.find(params[:id])
  end

  def send_video(disposition)
    @video = find_video
    file = @video.file.blob
    send_data file.download, filename: file.filename.to_s, type: file.content_type, disposition: disposition
  end
end
