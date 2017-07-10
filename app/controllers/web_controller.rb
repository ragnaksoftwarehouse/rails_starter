class WebController < ApplicationController
	def index
		render layout: 'guest'
	end
end