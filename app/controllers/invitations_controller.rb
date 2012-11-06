class InvitationsController < ApplicationController
  before_filter :authenticate
  before_filter :set_user

  def set_user
    @user = session[:login]
  end

  def accessible_invitation?
    @invitation = Invitation.find(params[:id])
    @invitation.owner_id == @user.id || @invitation.user_id == @user.id
  end

  def new
    @event = Event.find(params[:event_id])
    raise unless @event.user_id == @user.id
    @invitation = Invitation.new
    @users = User.all

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @invitation }
    end
  end

  def edit
    raise unless accessible_invitation?
  end

  def create
    @event = Event.find(params[:event_id])
    raise unless @event.user_id == @user.id
    @invitation = Invitation.new(params[:invitation])
    @invitation.owner_id = @user.id
    @invitation.event_id = params[:event_id]

    respond_to do |format|
      if @invitation.save
        format.html { redirect_to :controller => 'events', :action => 'show', :id => params[:event_id] }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    railse unless accessible_invitation?
    @invitation.owner_id = @user.id
    @invitation.event_id = params[:event_id]

    respond_to do |format|
      if @invitation.update_attributes(params[:invitation])
        format.html { redirect_to :controller => 'events', :action => 'show', :id => params[:event_id] }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @invitation = Invitation.find(params[:id])
    @invitation.destroy

    respond_to do |format|
      format.html { redirect_to :controller => 'events', :action => 'show', :id => params[:event_id] }
    end
  end
end
