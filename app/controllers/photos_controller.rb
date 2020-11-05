class PhotosController < ApplicationController
  def create
    @user = User.find(current_user.id)
    @user.photo.attach(params[:photo])
    redirect_to user_path(@user)
    
  end
end
