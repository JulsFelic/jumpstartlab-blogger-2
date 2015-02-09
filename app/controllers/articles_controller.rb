class ArticlesController < ApplicationController
  include ArticlesHelper
  before_action :get_user, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user, only: [:edit, :update, :destroy]
  before_filter :require_login, except: [:index, :show]

  def get_user
    @article = Article.find(params[:id])
  end

  def authenticate_user
    if @article.author_id != current_user.id
      redirect_to articles_path
    end
  end

  def require_login
    unless logged_in?
      redirect_to articles_path
    end
  end

  def index
    @articles = Article.all
  end

  def show
    @comment = Comment.new
    @comment.article_id = @article.id
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    @article = Article.new(article_params)
    @article.author_id = current_user.id
    @article.save

    flash.notice = "Article '#{@article.title}' Created!"

    redirect_to article_path(@article)
  end

  def update
    @article = Article.find(params[:id])
    @article.update(article_params)

    flash.notice = "Article '#{@article.title}' Updated!"

    redirect_to article_path(@article)
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    flash.notice = "Article '#{@article.title}' Destroyed!"

    redirect_to articles_path
  end
end
