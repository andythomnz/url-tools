class WebLinksController < ApplicationController
  before_action :set_web_link, only: :redirect

  def index
  end

  def redirect
    redirect_to @web_link.destination, allow_other_host: true
  end

  private

  def redirect_params
    params.require(:key)
  end

  def set_web_link
    @web_link = WebLink.find_by_key!(redirect_params)
  rescue ActiveRecord::RecordNotFound
    head :not_found
  end
end
