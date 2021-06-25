class Customer::SearchController < ApplicationController
    
  def search
    @value = params["search"]["value"]         #データを代入
    @how = params["search"]["how"]             #データを代入
    @datas = search_for(@how, @value)          #def search_forを実行(引数に検索ワードと検索方法)
    @genres = Genre.find_by(params[:name])
  end

  private

  def match(value)
    #.orを使用することで、valueに一致するカラムのデータをnameカラムとgenre_idカラムから探してきます。
    Item.where(name: value).or(Item.where(genre_id: value)).page(params[:page]).per(8)
  end

  def forward(value)                              #forward以降は商品名検索の定義しかしてません。
    Item.where("name LIKE ?", "#{value}%").page(params[:page]).per(8)        
  end

  def backward(value)
    Item.where("name LIKE ?", "%#{value}").page(params[:page]).per(8)
  end

  def partical(value)
    Item.where("name LIKE ?", "%#{value}%").page(params[:page]).per(8)
  end


  def search_for(how, value)
    case how                     #引数のhowと一致する処理に進むように定義しています。
    when 'match'                 #ジャンル検索の場合はmatchで固定してるので、必ず'match'の処理に進みます。
      match(value)
    when 'forward'
      forward(value)
    when 'backward'
      backward(value)
    when 'partical'
      partical(value)
    end
  end
end
