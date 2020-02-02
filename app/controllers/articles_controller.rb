class ArticlesController < ApplicationController
before_action :set_Article, only: [:edit, :update, :show, :destroy]
before_action :require_user, except: [:index, :show]
before_action :require_permissions, only: [:edit, :update, :destroy]

  def index
    @articles = Article.paginate(page: params[:page], per_page: 7)

  end

  def new
    @article = Article.new
  end

  def edit

  end

  def create
    # render plain: params[:Article].inspect
    @article = Article.new(Article_params)
    @article.user = current_user
    if @article.save
      flash[:success] = "Article was successfully created"
      redirect_to Article_path(@article)
    else
      render 'new'
    end
  end

  def update
    if @article.update(Article_params)
      flash[:success] = "Article was successfully updated"
      redirect_to Article_path(@article)
    else
      render 'edit'
    end
  end

  def show
  end

  def destroy
    @article.destroy
    flash[:danger] = "Article successfully deleted"
    redirect_to Articles_path
  end

  private
    def Article_params
      params.require(:Article).permit(:title, :description, :user_id)
    end

    def set_Article
      @article = Article.find(params[:id])
    end

    def require_permissions
      if @article.user != current_user && !admin?
        flash[:danger] = "You do not have permissions to perform that action"
        redirect_back(fallback_location: Articles_path)
      end
    end
end
