class EventsController < ApplicationController
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
end
