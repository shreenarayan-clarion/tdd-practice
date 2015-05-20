class StaticPagesController < ApplicationController
  def home
    @micropost = current_user.microposts.new if signed_in?
  end

  def help
  end

  def about
  end

  def contact
  end

end
