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

  def accessible_event
    conditions = ["id = ? and (public = ? or user_id = ?)", params[:id], 'public', @user.id]
    @event = Event.find(:all, :conditions => conditions)

    conditions = ["user_id = ? and event_id = ?", @user.id, params[:id]]
    @invitation = Invitation.find(:all, :conditions => conditions)
    @invitation = @invitation[0]
    if @event.blank?
      raise unless @invitation && @invitation.event
      @event = @invitation.event 
    end
  end

  def accessible_events
    conditions = ["public = ? or user_id = ?", 'public', @user.id]
    @events = Event.find(:all, :conditions => conditions)

    conditions = ["user_id = ?", @user.id]
    @invitations = Invitation.find(:all, :conditions => conditions)
    @invitations.each do |invitation|
      @events << invitation.event
    end
    @events = @events.uniq
  end

  def editable_event
    conditions = ["id = ? and user_id = ?", params[:id], @user.id]
    @event = Event.find(:all, :conditions => conditions)
    @event = @event[0]

    if @event.blank?
      conditions = ["user_id = ? and event_id = ?", @user.id, params[:id]]
      @invitation = Invitation.find(:all, :conditions => conditions)
      raise if @invitation.length == 0
      @event = @invitation[0].event
    end
    @event
  end

  def index
    accessible_events

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  def show
    accessible_event
    @is_own = is_own?
    conditions = ["event_id = ?", @event.id]
    @invitations = Invitation.find(:all, :order => "created_at ASC", :conditions => conditions)

    conditions = ["event_id = ?", @event.id]
    @comments = Comment.find(:all, :order => "created_at ASC", :conditions => conditions)
    @comment = Comment.new

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
    editable_event
  end

  def create
    params[:event][:public] = params[:event][:public] == "0" ? 'private' : 'public' 
    @event = Event.new(params[:event])
    @event.user_id = @user.id

    respond_to do |format|
      if @event.save
        @invitation = Invitation.new({"user_id" => @user.id, "event_id" => @event.id, "owner_id" => @user.id, "intention" => 'pending', "editable" => true})
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
    editable_event

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
