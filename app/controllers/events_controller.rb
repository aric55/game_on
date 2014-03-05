class EventsController < ApplicationController
	before_action :admin_user,     only: [:destroy, :create, :update]

  def new
  	if current_user.try(:admin?)
  		@event = Event.new
  	else
  		redirect_to root_url
  	end
  end

  def show
  	@event = Event.find(params[:id])
  end

  def index
  	@events = Event.paginate(page: params[:page])
  end

  def edit
  	if current_user.try(:admin?)
  		@event = Event.find(params[:id])
  	else
  		redirect_to root_url
  	end
  end

  def update
  	@event = Event.find(params[:id])
    if @event.update_attributes(event_params)
      flash[:notice] = "Event updated"
      redirect_to @event
    else
      render 'edit'
    end
  end

  def destroy
  	Event.find(params[:id]).destroy
    flash[:notice] = "Event deleted"
    redirect_to events_url
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      flash[:notice] = "Event Created"
      redirect_to @event
    else
      render 'new'
    end
  end

  private

    def event_params
      params.require(:event).permit(:name, :dateheld)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

end
 