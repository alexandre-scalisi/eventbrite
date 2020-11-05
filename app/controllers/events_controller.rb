class EventsController < ApplicationController
   before_action :authenticate_user! ,except: [:show, :index]
   before_action :check_right_user, only: [:destroy,:edit,:update]
  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def create
  
    @event= Event.new(params.require(:event).permit(:title,:description,:start_date,:price, :duration, :location))
    
    
    @event.administrator = current_user
     
    
    if @event.save
      @event.photo.attach(params.require(:event).permit(:photo)[:photo])
      flash[:notice] = 'Nouvel event ajouté avec succés'
      redirect_to event_path(@event.id)
    else
      flash.now[:alert] = "Echec lors de la création de l'event, veuillez réessayer"
      render :new
    end
  end

  def show
    @event = Event.find(params[:id])
  end
 
  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    flash[:notice] = "Event supprimé avec succés"
  end

  def edit
    @event = Event.find(params[:id])
  end
  def update
    @event = Event.find(params[:id])
    @event.update_attributes(params.require(:event).permit([:title],[:description],[:start_date],[:price], [:duration], [:location]))

    
    if @event.valid?
      flash[:notice] = 'Event modifié avec succés'
      redirect_to event_path(@event.id)
    else
      flash.now[:alert] = "Echec lors de la modification de l'event, veuillez réessayer"
      render :new
    end

  end
  

  def check_right_user

    if Event.find(params[:id]).administrator_id != current_user.id 
    flash[:alert] = "Ou tu vas petit filou?"
    redirect_to "/"  
    end
  end
end
