class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user_session, :current_user

  protected
  def permission_denied
    respond_to do |format|
      format.html { redirect_to('/403.html') rescue redirect_to('/signin') }
    end
  end

  private
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end

end
