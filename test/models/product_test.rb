require "minitest_helper"

describe Product do

  let(:product) { Product.new }
  

  it "must be valid" do    
    
    product.name = 'Tv'
    product.description = 'Samsung Smartv'
    product.price = 22.00
    product.inventory = 2
    product.active = true
    product.tags = "tv, smartv, samsung"    
    product.valid?.must_equal true
  end

  it "must be invalid without attributes" do
    product.valid?.must_equal false

    product.errors.size.must_equal 6
    product.errors[:name].wont_be_nil
    product.errors[:description].wont_be_nil
    product.errors[:inventory].wont_be_nil
    product.errors[:active].wont_be_nil
    product.errors[:tags].wont_be_nil    
  end

end
