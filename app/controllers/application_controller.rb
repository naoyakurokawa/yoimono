class ApplicationController < ActionController::Base
  include SessionsHelper
  protect_from_forgery with: :exception
  before_action :current_user

  private
   # ログイン済みユーザーかどうか確認
    def logged_in_user
      unless logged_in?
        flash[:info] = 'ご利用するにはログインが必要です'
        redirect_to login_path
      end
    end
end
