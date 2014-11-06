# The authentication process goes thru here
class LoginController < ApplicationController

  # POST /login.json
  def create
    creds = params.require(:credentials).permit([:nickname, :password])
    phone_info = params.require(:phone_info).permit([:device_id, :model, :build_json])
    user = User.find_by_nickname creds[:nickname]
    
    if user
      if user.authenticate(creds[:password])
        session[:user_id] = user.id
        redirect_to(:controller => 'users', :action => 'show', :id => user.id)
      else
        render json: {message: "password incorrect"}, status: :forbidden
      end
    else
      userinfo = User.create_new_user phone_info
      if userinfo
        user = userinfo[:user]
        password = userinfo[:password]
        render json: {nickname: user.nickname, password: password}
      else
        render json: {message: "could not create user"}, status: :unprocessable_entity
      end
    end
  end
end
