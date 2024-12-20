module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end
  def corrent_user 
    if session[:user_id]
      @corrent_user || User.find_by(id: session[:user_id])
    end
  end
  def logged_in?
    !current_user.nil?
  end

  def log_out
    reset_session
    @current_user =nil
  end
end
