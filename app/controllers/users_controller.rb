class UsersController < ApplicationController
  before_action :logged_in_user, only: %i[edit update show_mypage edit_mypage update_mypage]
  def new
    @user = User.new(flash[:user])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:notice] = "メールアドレス宛に承認メールを送りました。ご確認下さい。"
      redirect_to root_url
    else
      flash[:error_messages] = @user.errors.full_messages
      render new_user_path
    end
  end

  def show
    @user = User.find_by(name: params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(params)
      redirect_to mypage_path
    else
      flash[:error_messages] = @user.errors.full_messages
      render edit_user_path
    end
  end

  def following
    @title = "フォロー中ユーザー"
    @user  = User.find(params[:id])
    @users = @user.following
    # @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "フォロワー"
    @user  = User.find(params[:id])
    @users = @user.followers
    # @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  def show_mypage
    @user = @current_user
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :image)
  end
end
