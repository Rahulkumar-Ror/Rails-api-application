class Api::V1::ArticlesController < ApplicationController
	before_action :find_article, only: [:show, :update, :destroy]

	def index
		@articles = Article.all
		render json: @artilces
	end
  
	def show
		render json: @article
	end

  
  def create
    @article = Article.new(article_params)
    if @article.save!
      render json: @article, status: :created
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

	def update
    if @article.update(article_params)
      render json: { status: 'SUCCESS', message: 'Updated article successfully' }, status: :ok
    else
      render json: { status: 'ERROR', message: 'Unable to updated artcle' }, status: 400
    end
  end

	def destroy
	  @article.destroy
		render json: { status: 'SUCCESS', message: 'Deleted article successfully' }, status: :ok
	end

	def search
		@article = Article.find_by(title: params[:title])
		if @article
			@article = Article.where("title=?", @article.title)
			render json: @articles
		else
			render json: { message: "Unable to find article! " }, status: 400
		end
	end

	private 

	def find_article
	  @article = Article.find_by(id: params[:id])
	end

	def article_params
		params.require(:article).permit(:title, :body, :release_date)
	end
end
