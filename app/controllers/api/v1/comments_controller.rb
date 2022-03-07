class Api::V1::CommentsController < ApplicationController
  before_action :find_comment, only: [:show, :update, :destroy]

	def index
		@comments = Comment.all
		render json: @comments
	end

	def show
		render json: @comment 
	end

	def create
    @comment = Comment.new(comment_params)
    if @comment.save!
      render json: @comment, status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def update
    if @comment.update(comment_params)
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def destroy
		@comment.destroy 
		render json: { status: 'SUCCESS', message: 'Deleted comment' }, status: :ok
	end

  def search
    @comment = Comment.find_by(comment: params[:comment])
		if @comment
			@comments = Comment.where("comment=?", @comment.comment)
			render json: @comments
		else
			render json: { message: "Comment not found" }, status: 400
		end
	end

	private

	def find_comment
		@comment = Comment.find_by(id: params[:id])
	end

	def comment_params
    params.require(:comment).permit(:comment, :date_of_comment, :article_id)
	end
end
