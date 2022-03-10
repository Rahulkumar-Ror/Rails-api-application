class Api::V1::ArticlesController < ApplicationController
  before_action :find_article, only: [:show, :update, :destroy,:edit]

  def index
    @articles = Article.all
    render json:@articles
  end

	def show
    if @article
      render json:@article
    else
      render json: { error: "Couldn't find article " }
    end
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      render json:@article, status: :created
		else
			render json: @article.errors, status: :unprocessable_entity
    end
  end

  def update
    if @article
      @article.update(article_params)
      render json: { message: 'Article Successfully Updated!' }, status: 200
    else
      render json: { message: 'Unable to update article' }, status: 400
    end
  end

  def destroy
    if @article
      a = Array.new
      @article.comments.each do |article|
        a.push(article.id)
      end
      @article.destroy
      render json: { message:"Successfully deleted article " }, status: 200
    else
      render json: { error: "Couldn't find article with id #{params[:id]}" }
    end
  end

  def search
		@articles = Article.where("title LIKE '%#{params[:title]}%'")			
		if @articles
		  render json: @articles
		else
		  render json: { message: "Unable to find article! " }, status: 400
	  end
	end

  private
  def article_params
    params.require(:article).permit(:title, :body, :release_date)
  end

  def find_article
    @article = Article.find(params[:id])
  end
end
