class WelcomeController < ApplicationController
  def index
    if !current_user.present?
      redirect_to new_user_session_path
    else
      @devices = Device.active.search(params[:search]) if params[:search].present?
    end
  end

  def download_file
    upload= Upload.find(params[:id])
    if request.xhr?
      upload.destroy if upload.present?
    else
      send_file upload.attachment.path
    end
    
  end

end
