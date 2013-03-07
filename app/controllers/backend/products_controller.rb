class Backend::ProductsController < ApplicationController
	def index
		@products = current_admin.products
	end

	def show
	end
end
