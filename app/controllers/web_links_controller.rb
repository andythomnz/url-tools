class WebLinksController < ApplicationController
  before_action :set_web_link, only: :redirect

  def index
  end

  def redirect
    redirect_to @web_link.destination, allow_other_host: true
  end

  def create
    @web_link = WebLink.build(create_params)

    if @web_link.save
      redirect_to @web_link
    else
      render json: @web_link.errors, status: :unprocessable_entity
    end
  end

  def show
    @web_link = WebLink.find(show_params[:id])
  end



  def new
    @web_link = WebLink.new
  end

  private

  def redirect_params
    params.require(:key)
  end

  def create_params
    params.require(:web_link).permit(:key, :destination)
  end

  def show_params
    params.permit(:id)
  end

  def set_web_link
    @web_link = WebLink.active.find_by_key!(redirect_params)
  rescue ActiveRecord::RecordNotFound
    head :not_found
  end
end
