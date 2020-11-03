class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  before_action :check_right_user
  def show
    @user = current_user
    @events = @user.administered_events
  end

  def check_right_user

    if params[:id].to_i != current_user.id 
    flash[:alert] = "Ou tu vas petit filou?"
    redirect_to "/"  
    end
  end
end
