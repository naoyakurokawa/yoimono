class UsersController < ApplicationController
  before_action :logged_in_user, only: %i[show edit update show_mypage edit_mypage update_mypage]
  def new
    @user = User.new(flash[:user])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "メールアドレス宛に承認メールを送りました。ご確認下さい。"
      redirect_to root_url
    else
      flash[:info] = 'faild'
      redirect_to new_user_path
    end
  end

  def show
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(params)
      redirect_to mypage_path
    else
      render :edit_mypage
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :image)
  end
end
