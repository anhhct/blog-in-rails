class EntriesController < ApplicationController
	before_action :signed_in_user, only: [:create, :destroy]
	before_action :correct_user,   only: :destroy

	def create
		@entry = current_user.entries.build(entry_params)
		if @entry.save
			flash[:success] = "Entry posted!"
			redirect_to root_url
		else
			@feed_items = []
			render 'static_pages/home'
		end
	end

	def destroy
		@entry.destroy
		redirect_to root_url
		#redirect_to user_path(current_user)
	end

	def show
		@entry = Entry.find_by_id(params[:id])
		@title = @entry.title[0,50]
		@comment = current_user.comments.build if signed_in?
	end

	private
		def entry_params
			params.require(:entry).permit(:content, :title)
		end

		def correct_user
      @entry = current_user.entries.find_by(id: params[:id])
      redirect_to root_url if @entry.nil?
    end
end