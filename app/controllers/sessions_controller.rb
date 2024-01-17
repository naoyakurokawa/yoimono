class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to mypage_path
    else
      redirect_to login_path, flash: { login_messages: "メールアドレスまたはパスワードが誤っています" }
    end
  end

  def destroy
    log_out if logged_in?
    flash[:notice] = "ログアウトしました"
    redirect_to root_path
  end
end