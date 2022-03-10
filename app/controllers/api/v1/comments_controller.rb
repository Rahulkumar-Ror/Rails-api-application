class Api::V1::CommentsController < ApplicationController
  before_action :find_article, only: [:show, :update, :destroy, :edit, :create, :index]
  before_action :find_comment, only: [:show, :update, :destroy]

  def index
    if @article
      @comments = @article.comments
      render json:@comments
    else
      render json: { error: "Couldn't find article with provide id" }
    end
  end

  def create  
    if @article    
      @comment = @article.comments.new(comment_params)
    if @comment.save
      render json:@comment
    end

    else
      render json: { error: "Couldn't find article" }
    end
  end

  def show
    if @comment
      render json:@comment
    else
    render json: { error: "Couldn't find comment " }
    end
  end

  def update
    if @comment
      @comment.update(comment_params)
      render json: { error: " comment is successfully updated " }
    else
      render json: { error: "Couldn't find comment " }
    end
  end

  def destroy
    if @comment
      @comment.destroy
      render json: { message: "Successfully deleted comment " }
    else
      render json: { error: "Couldn't find comment "}
    end
  end

  def search
    @comments = Comment.where("comment LIKE '%#{params[:comment]}%'")		
    if @comments
      render json: @comments
    else
      render json: { message: "Unable to find comments!" }, status: 400
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:comment, :date_of_comment)
  end

  def find_comment
    @comment = @article.comments.find(params[:id])
  end

  def find_article
    @article = Article.find(params[:article_id])
  end
end
