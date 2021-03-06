class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @items = Item.page(params[:page]).per(10)
  end

  def new
    @item = Item.new
    @genres = Genre.all
  end

  def create
    @item = Item.new(params_item)

    if @item.save
      flash[:notice] = "新商品を登録しました"
      redirect_to admin_item_path(@item)
    else
      @genres = Genre.all
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
    @genres = Genre.all
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(params_item)
      flash[:success] = "商品内容を変更しました"
      redirect_to admin_item_path(@item)
    else
      @genres = Genre.all
      render :edit
    end
  end

  private

  def params_item
    params.require(:item).permit(:name, :introduction, :price, :genre_id, :sales_status, :image)
  end

end
