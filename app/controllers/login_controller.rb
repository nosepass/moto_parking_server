class LoginController < ApplicationController

  # POST /login.json
  def create
    params.require(:credentials).permit([:nickname, :password, :password_confirmation])
    params.require(:phone_info).permit([:device_id, :model, :build_json])
    #@spot = ParkingSpot.new(parking_params)

    creds = params[:credentials]
    phone_info = params[:phone_info]
    user = User.authenticate(creds[:nickname], creds[:password])
    if user
      redirect_to(:controller => 'users', :action => 'show', :id => user.id)
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
