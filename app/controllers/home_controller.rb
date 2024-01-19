class HomeController < ApplicationController
    def index
        @article = Article.first
        render "home/index"
    end

    def about
        @about = "Olaf"
        render "home/about"
    end
    
end