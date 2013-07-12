class UsersController < ApplicationController
  def index
    authorize! :index, @user, :message => 'Not authorized as an administrator.'
    @users = User.all
  end

  def show
    unless params[:id] == current_user.id || current_user.has_role?(:admin)
      redirect_to :back
    end

    @user = User.find(params[:id])
  end
end
