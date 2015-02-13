class UsersController < ApplicationController
  before_action :set_subject, only: [:show, :update]
  
  def show
  end

  def update
    respond_to do |format|
      phone_info = phone_info_params
      @subject.phone_info = phone_info
      if @subject.update(user_params)
        format.json { render :show, status: :ok, location: @subject }
      else
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subject
      @subject = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit([:nickname, :fname, :lname, :email, :password])
    end
end
