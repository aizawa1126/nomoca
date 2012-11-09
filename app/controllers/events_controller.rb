class EventsController < ApplicationController
  before_filter :authenticate
  before_filter :set_user

  def set_user
    @user = session[:login]
  end

  def is_own?
    @event = Event.find(params[:id])
    @event.user_id == @user.id
  end

  def accessible
    conditions = ["user_id = ? and event_id = ?", @user.id, params[:id]]
    @invitation = Invitation.find(:all, :conditions => conditions)
  end

  def accessible_list
    conditions = ["user_id = ?", @user.id]
    @invitations = Invitation.find(:all, :conditions => conditions)
    @events = Array.new
    @invitations.each do |invitation|
      @events << invitation.event
    end
  end

  def index
    accessible_list

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  def show
    raise unless accessible
    @is_own = is_own?
    conditions = ["event_id = ?", @event.id]
    @invitations = Invitation.find(:all, :conditions => conditions)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end

  def new
    @event = Event.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end

  def edit
    raise unless is_own?
  end

  def create
    @event = Event.new(params[:event])
    @event.user_id = @user.id

    respond_to do |format|
      if @event.save
        @invitation = Invitation.new({"user_id" => @user.id, "event_id" => @event.id, "owner_id" => @user.id, "intention" => 'pending'})
        @invitation.save

        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    raise unless is_own?

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

  def destroy
    raise unless is_own?
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end
end
