class ArticlesController < ApplicationController
    def index
        @articles = Article.all
    end

    def show
        @article = Article.find(params[:id])
    end

    def new
        @article = Article.new
    end
    
    def create
        @article = Article.new(article_params)
        if @article.save
            redirect_to article_path(@article), notice: "保存に成功しました！"
        else
            flash.now[:error] = "保存に失敗しました"
            render :new, status: :unprocessable_entity
        end
    end

    def edit
        @article = Article.find(params[:id])
    end

    def update
        @article = Article.find(params[:id])
        if @article.update(article_params)
            redirect_to article_path(@article), notice: "更新に成功しました！"
        else
            flash.now[:error] = "更新に失敗しました"
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @article = Article.find(params[:id])
        @article.destroy!
        redirect_to root_path, notice: "削除に成功しました。"
    end

    private
    def article_params
        params.require(:article).permit(:title, :content)
    end
end