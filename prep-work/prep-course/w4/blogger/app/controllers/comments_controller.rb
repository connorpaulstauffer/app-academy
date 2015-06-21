class CommentsController < ApplicationController

  include CommentsHelper

  before_filter :require_login, except: [:create]

  def create
    @comment = Comment.new(comment_params)
    if params[:parent_id]
      @comment.parent_id = params[:parent_id].to_i
    end
    @comment.article_id = params[:article_id]
    @comment.author_id = current_user.id

    @comment.save

    flash.notice = "Comment Created!"

    redirect_to article_path(@comment.article)
  end

  def upvote
    @comment = Comment.find_by_id(params[:id])
    @comment.update_attributes(upvotes: @comment.upvotes + 1)
    redirect_to article_path(@comment.article)
  end

  def downvote
    @comment = Comment.find_by_id(params[:id])
    @comment.update_attributes(downvotes: @comment.downvotes + 1)
    redirect_to article_path(@comment.article)
  end

end
