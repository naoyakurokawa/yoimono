class PasswordResetsController < ApplicationController
  before_action :get_user,   only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new; end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "メールアドレス宛にパスワードのリセット手順が記載されたメールを送信しました"
      redirect_to root_url
    else
      flash.now[:danger] = "ご記入のメールアドレスは登録されていません"
      render 'new'
    end
  end

  def edit; end

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, :blank)
      render 'edit'
    elsif @user.update(user_params)
      log_in @user
      flash[:success] = "パスワード再設定が完了しました"
      redirect_to mypage_path
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  # beforeフィルタ

  def get_user
    @user = User.find_by(email: params[:email])
  end

  # 有効なユーザーかどうか確認する
  def valid_user
    unless @user && @user.activated? &&
           @user.authenticated?(:reset, params[:id])
      redirect_to root_url
    end
  end

  # トークンが期限切れかどうか確認する
  def check_expiration
    return unless @user.password_reset_expired?

    flash[:danger] = "Password reset has expired."
    redirect_to new_password_reset_url
  end
end
