class HomeController < ApplicationController
  def index
    if current_admin
      redirect_to admins_path
    else
      redirect_to new_admin_session_path
    end
  end
end