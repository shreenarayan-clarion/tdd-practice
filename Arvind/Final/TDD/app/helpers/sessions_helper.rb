module SessionsHelper

  #This action update the remember token detail.
  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.digest(remember_token))
    self.current_user = user
  end

  #This action return the current user
  def current_user=(user)
    @current_user = user
  end

  #This action retrieve current user from browser token
  def current_user
    remember_token = User.digest(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end

  #This action return currently user signed-in or not
  def signed_in?
    !current_user.nil?
  end

  #This action log-out the current user
  def sign_out
    current_user.update_attribute(:remember_token,
    User.digest(User.new_remember_token))
    cookies.delete(:remember_token)
    self.current_user = nil
  end

  #Authorized the current user for protected actions
  def current_user?(user)
    user == current_user
  end

  #This action store the user browser request in log-out mode
  def store_location
    session[:return_to] = request.url if request.get?
  end

  #This action redirected the user to the requested page which requested by user in log-out mode after sign-in
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  # This action check the user signed-in or not
  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end

  # This action will check the current user for protected actions.
  def correct_user
    @user = User.find(params[:id])
    unless current_user?(@user)
      redirect_to root_url, notice: "You are not authorized for this action."
    end
  end

end
