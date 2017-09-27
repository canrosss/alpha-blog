class ArticlesController < ApplicationController
  def new(*args)

    @article = Article.new
  end

  def create(*args)
#    render plain: params[:article].inspect
    #Primero creamos una variable de instance
    #Necesitaremos filtrar los parametros
 #   @article.save
    #Despues de salvar nos debe de mandar a show
    #
  #  redirect_to articles_show(@article)
    #


    @article = Article.new(article_params)

    if @article.save
      #do something
      flash[:notice] = "Article was a successfully created"
      redirect_to articles_path(@article)
    else
      render 'new'
    end
  end

  def show(*args)
    @article = Article.find(params[:id])
  end

  private
    def article_params(*args)
      #Pedimos que require ciertos parametros
      params.require(:article).permit(:tittle, :description)

    end
end
