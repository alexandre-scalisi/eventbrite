class AttendancesController < ApplicationController
  before_action :authenticate_user! 
  before_action :check_right_user
  def new    
  end

  def create
    
    @event = Event.find(params[:event_id])
        @amount = @event.price
      if @amount.zero?
        @event.attendees << current_user
        redirect_to @event
        return
      end

        customer = Stripe::Customer.create({
          email: params[:stripeEmail],
          source: params[:stripeToken],
        })
      
        charge = Stripe::Charge.create({
          customer: customer.id,
          amount: @amount,
          description: 'Rails Stripe customer',
          currency: 'usd',
        })

        @event.attendees << current_user
        flash[:notice] = "Vous participez à l'évenement"
        redirect_to @event
        
  rescue Stripe::CardError => e
    flash[:alert] = e.message
    
      
        
        
  end

  def index
   @event = Event.find(params[:event_id])
  end

  def check_right_user
    @event = Event.find(params[:event_id])
    if @event.administrator_id != current_user.id && !@event.price.zero?
    flash[:alert] = "Ou tu vas petit filou?"
    redirect_to "/"  
    end
  end
end
