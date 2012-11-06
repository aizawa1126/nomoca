class InvitationsController < ApplicationController
  before_filter :authenticate
  before_filter :set_user

  def set_user
    @user = session[:login]
  end

  # GET /invitations/new
  # GET /invitations/new.json
  def new
    @invitation = Invitation.new
    @users = User.all

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @invitation }
    end
  end

  # GET /invitations/1/edit
  def edit
    @invitation = Invitation.find(params[:id])
  end

  # POST /invitations
  # POST /invitations.json
  def create
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

  # PUT /invitations/1
  # PUT /invitations/1.json
  def update
    @invitation = Invitation.find(params[:id])
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

  # DELETE /invitations/1
  # DELETE /invitations/1.json
  def destroy
    @invitation = Invitation.find(params[:id])
    @invitation.destroy

    respond_to do |format|
      format.html { redirect_to :controller => 'events', :action => 'show', :id => params[:event_id] }
    end
  end
end
