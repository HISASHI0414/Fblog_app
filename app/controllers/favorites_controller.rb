class FavoritesController < ApplicationController
  before_action :authenticate_user!
  def index
    @articles = current_user.favorite_articles #これはuser.rb内で定義したメソッド
  end
end
