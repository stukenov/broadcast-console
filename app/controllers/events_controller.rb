class EventsController < ApplicationController
  def index
    @channels = Channel.all
  end

  def channel_index
    @channel = Channel.find(params[:channel_id])
    @events = @channel.events_id
  end

  def show
    @event = find_event
  end

  def new
    @channel = Channel.find(params[:channel_id])
    @event = @channel.events_id
  end

  def create
    @channel = Channel.find(params[:channel_id])
    @event = @channel.events_id(event_params)
    if @event.save
      redirect_to channel_event_path(@channel, @event)
    else
      render :new
    end
  end

  def edit
    @event = find_event
    @videos = fetch_all_videos
  end

  def update
    @event = find_event
    if @event.update(event_params)
      redirect_to channel_event_path(@event.channel, @event)
    else
      render :edit
    end
  end

  def destroy
    @event = find_event
    @event.destroy
    redirect_to channel_events_path(@event.channel)
  end

  def generate
    @channel = Channel.find(params[:channel_id])
  end

  def generate_events
    @channel = Channel.find(params[:channel_id])
    @start_time = params[:start_time]
    @end_time = params[:end_time]
    @videos = fetch_all_videos
    @events = Event.generate_events(@start_time, @end_time, @videos)
    @events.each { |event| event.update(channel: @channel) }
    redirect_to channel_events_path(@channel)
  end

  private

  def fetch_events_for_today
    Event.where(start_time: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
  end

  def fetch_all_videos
    Video.all
  end

  def find_event
    Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:name, :start_time, :videos_id, :channel_id)
  end

  def generate_events_params
    params.require(:start_time)
  end
end
