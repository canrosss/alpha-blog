class ArticlesController < ApplicationController


  def index(*args)
    @articles = Article.all #Consigue todos los articulos desde la DB
  end

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

  def edit(*args)
    @article = Article.find(params[:id])
  end


  def show(*args)
    @article = Article.find(params[:id])
  end

  def update(*args)

    @article = Article.find(params[:id])
    if @article.update(article_params)
      flash[:notice] = "Article was successfully updated"
      redirect_to articles_path
    else
      render 'edit'
    end

  end

  def destroy(*args)
    #Buscamos el articulo basado en el id
    @article = Article.find(params[:id])
    @article.destroy
    flash[:notice] = "Article was successfully deleted!"
    redirect_to articles_path
  end

  private
    def article_params(*args)
      #Pedimos que require ciertos parametros
      params.require(:article).permit(:tittle, :description)

    end


end
