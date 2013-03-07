class Backend::ProductsController < ApplicationController
	def index
		@products = current_admin.products
	end

	def new
		@product = Product.new
		5.times { @product.images.build }

		respond_to do |format|
      format.html
    end		
	end

	def create
	  @product = Product.new(product_params)
	  @product.admin = current_admin

	  unless params[:product][:images_attributes].nil?
	  		params[:product][:images_attributes].each do |i, v|
	  			@product.images.build v
	  		end
	  end

	  if @product.valid?
	  	@product.save
	  	return redirect_to backend_products_path
	  end

	  respond_with @product
	end

	protected
  def product_params 
  	params.require(:product).permit(:name, :description, :price, :inventory, :active, :tags)
  end
end
