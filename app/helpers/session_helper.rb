module SessionHelper
  def set_session(user_object)
    session[:user_id] = user_object.id
    session[:district_id] = user_object.district.id if user_object.district
  end

  def create_regular_user(user_email)
    user = RegularUser.find_by_email(user_email)
      if user && user.authenticate(user_email)
        set_session(user)
        redirect_to cookies[:redirect_to_after_login] || root_path
      else
        @error = "Invalid Login"
        render action: 'new'
      end
  end

  def create_oauth_user(authorization_request, user)
    oauth = OAuthUser.new(authorization_request, user)
    oauth.login_or_create
    set_session(oauth.user)
    redirect_to cookies[:redirect_to_after_login] || root_path
  end
end

