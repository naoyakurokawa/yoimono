class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.update_attribute(:activated,    true)
      user.update_attribute(:activated_at, Time.zone.now)
      user.activate
      log_in user
      flash[:success] = "本登録の手続きが完了しました"
      redirect_to mypage_path
    else
      flash[:danger] = "承認リンクが不正のため手続き完了できませんでした"
      redirect_to root_url
    end
  end
end
