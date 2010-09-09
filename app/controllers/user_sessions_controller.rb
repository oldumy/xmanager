# encoding: utf-8
class UserSessionsController < ApplicationController
  skip_before_filter :require_user, :except => :destroy

  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new params[:user_session]
    if @user_session.save
      flash[:notice] = '登录成功!'
      redirect_to root_path
    else
      render 'new'
    end
  end

  def destroy
    current_user_session.destroy if current_user_session
    redirect_to signin_path
  end
end
