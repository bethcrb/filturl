# This controller is used for rendering custom error pages.
class ErrorsController < ApplicationController
  def show
    if status_code == '404'
      redirect_to root_path
    else
      render status_code.to_s, status: status_code
    end
  end

  protected
 
  def status_code
    params[:status] || 500
  end
end
