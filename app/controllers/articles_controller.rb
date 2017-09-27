class ArticlesController < ApplicationController
  def new(*args)

    @article = Article.new
  end

  def create(*args)
#    render plain: params[:article].inspect
    #Primero creamos una variable de instance
    #Necesitaremos filtrar los parametros
    @article = Article.new(article_params)
    @article.save
  end

  private
    def article_params(*args)
      #Pedimos que require ciertos parametros
      params.require(:article).permit(:tittle, :description)

    end
end
