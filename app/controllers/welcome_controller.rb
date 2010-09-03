class WelcomeController < ApplicationController
  def index
    @user = current_user
    if(current_user)
      respond_to do |format|
        format.html
      end
    else
      redirect_to('/signin')
    end
  end

end
