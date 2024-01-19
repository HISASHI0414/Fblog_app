class ArticlesController < ApplicationController
    def index
        @article = Article.first
        render "articles/index"
    end
end