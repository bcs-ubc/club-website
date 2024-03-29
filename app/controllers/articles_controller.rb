class ArticlesController < ApplicationController
before_action :set_article, only: [:edit, :update, :show, :destroy]
before_action :require_user, only: [:create, :edit, :update, :destroy]
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
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:success] = "Event was successfully created"
      redirect_to articles_path(@article)
    else
      render 'new'
    end
  end

  def update
    if @article.update(article_params)
      flash[:success] = "Event was successfully updated"
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  def show
  end

  def destroy
    @article.destroy
    flash[:danger] = "Article successfully deleted"
    redirect_to articles_path
  end

  def hackathon2020
  end

  private
    def article_params
      params.require(:article).permit(:title, :description, :user_id, :start_time, :start_date)
    end

    def set_article
      @article = Article.friendly.find(params[:id])
    end

    def require_permissions
      if @article.user != current_user && !admin?
        flash[:danger] = "You do not have permissions to perform that action"
        redirect_back(fallback_location: articles_path)
      end
    end
end
