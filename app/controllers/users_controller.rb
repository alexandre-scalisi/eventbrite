class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :edit]
  before_action :check_right_user, only: [:show,:edit]
  def show
    @user = current_user
    @events = @user.administered_events
  end


  def edit
    @user = User.find(current_user.id)

  end

  def update
    @user = User.find(current_user.id)
    @user.update(params.require(:user).permit(:description, :first_name, :last_name))
    
  
   
    if @user.valid?
    
      flash[:notice] = 'User modifié avec succés'
      redirect_to user_path(@user.id)
    else
      flash.now[:alert] = 'Echec lors de la modification du User, veuillez réessayer'
      render :edit
    end
  end
  private 
  def check_right_user

    if params[:id].to_i != current_user.id 
    flash[:alert] = "Ou tu vas petit filou?"
    redirect_to "/"  
    end
  end
end
