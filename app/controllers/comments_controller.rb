class CommentsController < ApplicationController
  before_filter :authenticate
  before_filter :set_user

  def set_user
    @user = session[:login]
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def create
#puts "===="
#puts params.inspect
    @comment = Comment.new(params[:comment])
    @comment.user_id = @user.id.to_i
    @comment.event_id = params[:event_id].to_i
#puts "====="
#puts @comment.inspect

    @comment.save unless @comment.content.blank?
    respond_to do |format|
      format.html { redirect_to :controller => 'events', :action => 'show', :id => params[:event_id] }
    end
  end

  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if !params[:comment][:content].blank? && @comment.update_attributes(params[:comment])
        format.html { redirect_to :controller => 'events', :action => 'show', :id => params[:event_id] }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to :controller => 'events', :action => 'show', :id => params[:event_id] }
    end
  end
end
