class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :update, :show, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index(*args)
   # @articles = Article.all #Consigue todos los articulos desde la DB
    @articles = Article.paginate(page: params[:page], per_page: 5)

  end

  def new(*args)
    @article = Article.new
  end

  def create(*args)

#    debugger
#    render plain: params[:article].inspect
    #Primero creamos una variable de instance
    #Necesitaremos filtrar los parametros
 #   @article.save
    #Despues de salvar nos debe de mandar a show
    #
  #  redirect_to articles_show(@article)
    #


    @article = Article.new(article_params)
 #   @article.user = User.first
    @article.user = current_user

    if @article.save
      #do something
      flash[:success] = "Article was a successfully created"
      redirect_to articles_path(@article)
    else
      render 'new'
    end
  end

  def edit(*args)
  end


  def show(*args)
  end

  def update(*args)
    if @article.update(article_params)
      flash[:success] = "Article was successfully updated"
      redirect_to articles_path
    else
      render 'edit'
    end
  end

  def destroy(*args)
    #Buscamos el articulo basado en el id
    @article.destroy
    flash[:danger] = "Article was successfully deleted!"
    redirect_to articles_path
  end

  private
    def set_article(*args)
      @article = Article.find(params[:id])
    end

    def article_params(*args)
      #Pedimos que require ciertos parametros
      params.require(:article).permit(:tittle, :description)
    end

    def require_same_user(*args)
      if current_user != @article.user and !current_user.admin?
        flash[:danger]="You can only edit or delete your own articles"
        redirect_to root_path
      end
    end

end
