class ItemsController < ApplicationController
  before_action :logged_in_user, only: %i[new edit]
  def new
    @item = Item.new(flash[:item])
  end

  def create
    @item = Item.new(item_params)
    @item.user_id = @current_user.id
    if @item.save
      flash[:notice] = "モノを登録しました"
      redirect_to top_index_path
    else
      flash[:error_messages] = @item.errors.full_messages
      render new_item_path
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
      flash[:notice] = "モノを登録しました"
      redirect_to top_index_path
    else
      flash[:error_messages] = @item.errors.full_messages
      render new_item_path
    end
  end

  private

  def item_params
    params.require(:item).permit(:title, :detail, :image)
  end
end
