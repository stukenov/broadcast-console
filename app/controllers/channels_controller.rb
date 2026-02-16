class ChannelsController < ApplicationController
  def index
    @channels = Channel.all
  end

  def show
    @channel = Channel.find(params[:id])
    @servers = Server.all
    if @channel.server_id
      @server = Server.find(@channel.server_id)
    end
  end

  def new
    @channel = Channel.new
    @servers = Server.all
  end

  def create
    @channel = Channel.new(channel_params)
    if @channel.save
      redirect_to channels_path, notice: 'Channel was successfully created.'
    else
      @servers = Server.all
      render :new
    end
  end

  def update
    @channel = Channel.find(params[:id])
    if @channel.update(channel_params)
      redirect_to @channel, notice: 'Channel was successfully updated.'
    else
      @servers = Server.all
      render :edit
    end
  end

  def destroy
    @channel = Channel.find(params[:id])
    @channel.destroy
    redirect_to channels_path, notice: 'Channel was successfully deleted.'
  end

  def edit
    @channel = Channel.find(params[:id])
    @servers = Server.all
  end

  def assign_server
    @channel = Channel.find(params[:id])
    @channel.server = Server.find(params[:server_id])
    if @channel.save
      redirect_to @channel, notice: 'Channel was successfully assigned to server.'
    else
      @servers = Server.all
      render :edit
    end
  end

  private

  def channel_params
    params.require(:channel).permit(:name, :server_id)
  end
end
