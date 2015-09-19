module SessionsHelper
  def session_params
    params.require(:user).permit(:username, :password)
  end
end
