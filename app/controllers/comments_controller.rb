class CommentsController < ApplicationController
	before_action :signed_in_user
	before_action :correct_user, only: :destroy

	def create
		@comment = current_user.comments.build(comment_params)
		if @comment.save
			flash[:success] = "Comment posted!"
			redirect_to :back
		else
			flash[:error] = "Fail to post comment!"
			redirect_to :back
		end
	end
	def destroy
		@comment.destroy
		redirect_to :back
	end

	private
		def comment_params
			params.require(:comment).permit(:content, :entry_id)
		end

		def correct_user
      @comment = current_user.comments.find_by(id: params[:id])
      redirect_to root_url if @comment.nil?
    end
end