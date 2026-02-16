class LicencesController < ApplicationController
  before_action :set_licence, only: [:show, :edit, :update, :destroy]

  def index
    @licences = Licence.all
  end

  def show
    @servers = Server.where(licence_id: @licence.id)
  end

  def generate
    Licence.create(key: SecureRandom.uuid.delete("-"), status: "active")
    redirect_to licences_path
  end

  def edit
  end

  def update
    if @licence.update(licence_params)
      redirect_to licences_path
    else
      render :edit
    end
  end

  def destroy
    @licence.destroy
    redirect_to licences_path
  end

  private

  def set_licence
    @licence = Licence.find(params[:id])
  end

  def licence_params
    params.require(:licence).permit(:key, :status)
  end

  def licence_servers_params
    params.require(:licence).permit(:servers)
  end
end
