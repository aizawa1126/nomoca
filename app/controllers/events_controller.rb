class EventsController < ApplicationController
  before_filter :authenticate
  before_filter :set_user

  def set_user
    @user = session[:login]
  end

  def owner?
    @event = Event.find(params[:id])
    @event.user_id == @user.id
  end

  def accessible
    owner?
  end

  def accessible_list
    conditions = ["user_id = ?", @user.id]
    @events = Event.find(:all, :conditions => conditions)
  end

  # GET /events
  # GET /events.json
  def index
    accessible_list

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    raise unless accessible

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/new
  # GET /events/new.json
  def new
    @event = Event.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/1/edit
  def edit
    raise unless owner?
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(params[:event])
    @event.user_id = @user.id

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    raise unless owner?

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    raise unless owner?
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end
end
