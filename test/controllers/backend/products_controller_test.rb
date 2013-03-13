require "minitest_helper"

describe Backend::ProductsController do
  before do
    stub_current_admin
  end
  
  describe 'show' do
    it "when haven't products" do          
      get :show, id: 200

      assert_response :success    
      assigns[:product].wont_be_nil      
    end

    it "when have products" do      
      get :index
      
      assert_response :success
      assert_template :index
      assigns[:products].wont_be_nil
    end
  end
  
  describe 'new' do
    let(:params) {
      {
        product: { name: 'Toshiba TV', description: 'Toshiba 3D Smart TV 50"', price: 1200, inventory: 2, active: true, tags: 'tv' }
      }
    }
    
    it "should method new display a form to register a new product" do
      get :new, params

      assert_response :success
      assert_template :new
      assigns[:product].wont_be_nil
    end
  end
  
  describe 'edit' do
    let(:params) {
      {
        product: { id: 1, name: 'Samsung TV', description: 'Samsung Smart TV 49"', price: 8500, inventory: 4, active: true, tags: 'samsung' } 
      }
    }
    
    it "should display a form to edit the product attributes if admin own the product" do
      get :edit, parms
      
      assert_response :success
      assert_template :edit
      assigns[:product].wont_be_nil
    end
   end
  
#   describe 'update' do
#     let(:params) {
#       {
#         product: { id: 2, name: 'Samsung TV', description: 'Samsung Smart TV 46"', price: 8500, inventory: 4, active: true }
#       }
#     }
  
#     it 'should redirect to create product when the admin is not logged in' do
#       stub_current_admin 200

#       #put :update, params

#       assert_redirected_to new_backend_product_path
#       flash[:notice].wont_be_nil
#     end

#     it "should update a product and redirect to product show" do
#       #put :update, params

#       assert_redirected_to backend_product_path
#       flash[:notice].wont_be_nil
#     end

#     it "should display edit form if product is invalid" do
#       params[:product][:name] = nil

#       #put :update, params

#       assert_response :success
#       assert_template :edit
#       flash[:alert].wont_be_nil
#     end
#   end
end
