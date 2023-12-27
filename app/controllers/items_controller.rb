class ItemsController < ApplicationController
  before_action :logged_in_user, only: %i[new edit]
  def new
    @item = Item.new(flash[:item])
  end

  def create
    item = Item.new(item_params)
    item.user_id = @current_user.id
    if item.save
      redirect_to mypage_path
    else
      flash[:item] = item
      flash[:error_messages] = item.errors.full_messages
      redirect_back fallback_location: 'http://localhost'
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(params)
      redirect_to item_path
    else
      render :edit_mypage
    end
  end

  private

  def item_params
    params.require(:item).permit(:title, :detail, :image, :image_cache)
  end
end
