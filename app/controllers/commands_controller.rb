class CommandsController < ApplicationController
  before_action :set_command, only: [:show, :destroy, :update, :status, :update_status]
  before_action :set_server, only: [:show]

  def index
    @commands = Command.order(created_at: :desc)
    filter_commands_by_server if params[:server_id].present?
  end

  def show
    format_command_logs if @command.logs.present?
  end

  def new
    @command = Command.new
  end

  def create
    @command = Command.new(command_params.merge(status: "pending"))
    if @command.save
      redirect_to commands_path
    else
      render :new
    end
  end

  def destroy
    @command.destroy
    redirect_to commands_path
  end

  def update
    if @command.update(command_params)
      redirect_to commands_path
    else
      render :edit
    end
  end

  def status
    render json: { status: @command.status }
  end

  def update_status
    if @command.update(status: params[:status])
      render json: { status: @command.status }
    else
      render json: { error: "Unable to update status" }, status: :unprocessable_entity
    end
  end

  private

  def command_params
    params.require(:command).permit(:server_id, :command, :target, :length, :status)
  end

  def set_command
    @command = Command.find(params[:id])
  end

  def set_server
    @server = Server.find(@command.server_id)
  end

  def filter_commands_by_server
    @commands = @commands.where(server_id: params[:server_id])
  end

  def format_command_logs
    @command.logs = JSON.parse(@command.logs).join("\n")
  end
end
