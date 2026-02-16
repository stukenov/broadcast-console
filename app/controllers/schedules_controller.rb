class SchedulesController < ApplicationController

    before_action :select_channel

    def index
        @channels = Channel.all
    end

    

    def channel_index

        date = today_date
        redirect_to channel_schedules_by_date_path(params[:channel_id], params[:date] = date)
    end

    def channel_index_by_date
        @schedules = Schedule.all
        @channel = Channel.find(params[:channel_id])
        @date = params[:date]
        if params[:event_id]
            @schedules = @schedules.where(event_id: params[:event_id])
        end
        if params[:channel_id]
            @schedules = @schedules.where(channel_id: params[:channel_id])
        end
    end

    def new
        @schedule = Schedule.new
        @channel = Channel.find(params[:channel_id])
        @date = params[:date]
        if params[:event_id]
            @schedule.event = Event.find(params[:event_id])
        end
        @schedule.channel_id = @channel
    end

    def create
        @schedule = Schedule.new(schedule_params)
        @date = params[:date]
        @schedule.date = @date
        if params[:event_id]
            @schedule.event = Event.find(params[:event_id])
        end
        if params[:channel_id]
            @schedule.channel = Channel.find(params[:channel_id])
        end
        if @schedule.save
            redirect_to schedules_path
        else
            render :new
        end
    end

    def edit
        @schedule = Schedule.find(params[:id])
        @date = params[:date]
        @schedule.date = @date
        if params[:event_id]
            @schedule.event = Event.find(params[:event_id])
        end
        if params[:channel_id]
            @schedule.channel = Channel.find(params[:channel_id])
        end
    end

    def update
        @schedule = Schedule.find(params[:id])
        @date = params[:date]
        @schedule.date = @date
        if @schedule.update(schedule_params)
            redirect_to schedules_path
        else
            render :edit
        end
    end

    def destroy
        @schedule = Schedule.find(params[:id])
        @date = params[:date]
        @schedule.date = @date
        @schedule.destroy
        redirect_to schedules_path
    end

    def show
        @schedule = Schedule.find(params[:id])
        @date = params[:date]
        @schedule.date = @date
        if params[:event_id]
            @schedule.event = Event.find(params[:event_id])
        end
        if params[:channel_id]
            @schedule.channel = Channel.find(params[:channel_id])
        end
    end

    

    private

    def schedule_params
        params.require(:schedule).permit(:name, :start_time, :end_time, :event_id, :channel_id)
    end

    def today_date
        Date.today.strftime("%Y%m%d")
    end

    def select_channel
        if params[:channel_id]
            @channel = Channel.find(params[:channel_id])
        else
            redirect_to channels_path, alert: "Channel not found"
        end
    end

    
end
