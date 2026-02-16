class ServersController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:adapto_commands, :adapto_commands_status, :register]
  skip_before_action :authorize, only: [:adapto_commands, :adapto_commands_status, :register]


  def index
    @servers = Server.all
  end

  def show
    @server = find_server(params[:id])
    @licence = find_licence(@server.licence_id)
    return render_not_found if @server.nil? || @licence.nil?

    @commands = find_commands(@server.id)
  end

  def commands
    @server = find_server(params[:id])
    @commands = find_commands(@server.id)
  end

  def adapto_commands
    server = find_server_by_name(params[:servername])
    return render_not_found if server.nil?

    licence = find_licence_by_key(request.headers['Authorization'])
    return render_unauthorized if licence.nil?

    command = find_pending_command(server.id)
    return render_no_command if command.nil?

    render_command_response(params[:servername], command)
  end

  def adapto_commands_status
    command = find_command(params[:id])
    return render_not_found if command.nil?

    update_command_status(command, params[:status], params[:logs], params[:response])
    render json: { message: "DONE" }
  end

  def register
    licence = find_licence_by_key(request.headers['Authorization'])
    return render_unauthorized if licence.nil?

    return render_bad_request if params[:serverName].blank? || params[:resources].blank?

    server = find_or_create_server(params[:serverName])
    update_server_resources(server, params[:resources], licence.id)
    render json: { message: "Server registered successfully" }
  end

  private

  def find_server(id)
    Server.find(id)
  end

  def find_licence(id)
    Licence.find(id)
  end

  def find_commands(server_id)
    Command.where(server_id: server_id)
  end

  def find_server_by_name(name)
    Server.find_by(name: name)
  end

  def find_licence_by_key(auth_header)
    key = auth_header.split(' ').last
    Licence.find_by(key: key)
  end

  def find_pending_command(server_id)
    Command.find_by(server_id: server_id, status: "pending")
  end

  def find_command(id)
    Command.find_by(id: id)
  end

  def update_command_status(command, status, logs, response)
    command.update(status: status, logs: logs, response: response)
  end

  def find_or_create_server(name)
    Server.find_or_create_by(name: name)
  end

  def update_server_resources(server, resources, licence_id)
    server.update(cpu: resources[:cpu], total_memory: resources[:totalMemory], licence_id: licence_id)
  end

  def render_not_found
    render json: { error: "404 Not Found" }, status: :not_found
  end

  def render_unauthorized
    render json: { error: "401 Unauthorized" }, status: :unauthorized
  end

  def render_no_command
    render json: { message: "NOCOMMAND" }
  end

  def render_command_response(servername, command)
    render json: { message: "command for #{servername}", command: { id: command.id, target: command.target, length: command.length, command: command.command } }
  end

  def render_bad_request
    render json: { error: "All fields are required" }, status: :bad_request
  end
end
