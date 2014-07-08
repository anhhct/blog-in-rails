class StaticPagesController < ApplicationController
	def home
		if signed_in? then
  		@feed_items = current_user.feed.paginate(page: params[:page])
  	else
  		@feed_items = []
  	end
	end
	def compose
	@entry = current_user.entries.build if signed_in?		
	end
end
