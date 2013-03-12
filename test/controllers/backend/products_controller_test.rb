require "minitest_helper"

describe Backend::ProductsController do
  before do
    stub_current_admin
  end
  
  describe 'show' do
    it "when admin have no products" do
      stub_current_admin 100

      get :new

      assert_redirected_to new_backend_product_path
    end

    it "when admin have products" do
      puts stub_current_admin.inspect
      
      @product = Product.my_products(stub_current_admin).first
      
      get :show

      assert_not_nil(@product, '')
      assert_response :success
      assert_template :show
      assigns[:product].wont_be_nil
    end
  end
  
  describe 'new' do
    let(:params) {
      {
        product: { name: 'Toshiba TV', description: 'Toshiba 3D Smart TV 50"', price: 1200, inventory: 2, active: true }
      }
    }
    
    it "should method new display a form to register a new product" do
      stub_current_admin 200
      
      get :new, params

      assert_response :success
      assert_template :new
      assigns[:product].wont_be_nil
    end
  end
  
  describe 'edit' do
    it "should method edit display a form to edit the product attributes if admin own the product" do
      get :edit
      
      assert_response :success
      assert_template :edit
      assigns[:product].wont_be_nil
    end

    it "should redirect to new when user have no products to edit" do
      stub_current_admin 200
    
      get :edit
      
      assert_redirected_to new_backend_product_path
      flash[:notice].wont_be_nil
    end
  end
  
  describe 'update' do
    let(:params) {
      {
        product: { id: 1, name: 'Samsung TV', description: 'Samsung Smart TV 46"', price: 8500, inventory: 4, active: true,
          admin_attributes: { id: 100 }
        }
      }
    }

    it "should update a product and redirect to product show" do
      put :update, params

      assert_redirected_to backend_product_path
      flash[:notice].wont_be_nil
    end

    it "should display edit form if product is invalid" do
      params[:product][:name] = nil

      put :update, params

      assert_response :success
      assert_template :edit
      flash[:alert].wont_be_nil
    end
  end
end


def stub_current_admin(id = 100)
  Backend::ProductController.class_exec(id) do |id|
    body = -> { @admin ||= Admin.find id }
    define_method :current_admin, body
  end
end