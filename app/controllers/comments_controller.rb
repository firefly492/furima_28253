class CommentsController < ApplicationController
  def new
    # @comments = Comment.all
    @comment = Comment.new
  end

  def create
    comment = Comment.create(comment_params)
    if comment.save
      redirect_to item_path method: :POST
    #   ActionCable.server.broadcast 'comment_channel', content: @comment
    end
  end

  private

  def comment_params
    params.permit(:text).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end

