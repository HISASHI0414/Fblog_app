class HomeController < ApplicationController
    def index
        @title = "デイトラ"
        @title2 = "デイトラ2"
        render "home/index"
    end

    def about
        @about = "Olaf"
        render "home/about"
    end
    
end