class Backend::ProductsController < ApplicationController
	def index
		@products = Product.my_products(current_admin)
	end

	def new
		@product = Product.new
		5.times { @product.images.build }
	end

	def create
	  @product = Product.new(product_params)
	  @product.inventory = -1 if params[:product][:inventory_check] == "1" 
	  @product.admin = current_admin
	  upload_files params[:product][:images_attributes]

	  if @product.save
	  	return redirect_to backend_products_path, notice: "Producto creado"
	  end

	  flash[:notice] = "Product no creado"
	  5.times { @product.images.build }
	  render :new 
	end

	def edit
   	@product = Product.my_product(params[:id], current_admin).first
    
    if @product.nil?
      return redirect_to backend_products_path, alert: "Producto no encontrado"
    end
    
    (5 - @product.images.count).times { @product.images.build }
    
    if @product.inventory == -1
      @product.inventory = ""
      @product.inventory_check = true 
    end
	end

	protected
  def product_params 
  	params.require(:product).permit(:name, :description, :price, :inventory, :active, :tags)
  end

  def upload_files files
  	unless files.blank?
	  		files.each do |key, value|
	  			@product.images.build value
	  		end
	  end
  end
end
