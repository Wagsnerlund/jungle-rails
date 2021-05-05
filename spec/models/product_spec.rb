require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
  
    it "should be valid" do
      @product = Product.new({
        name: 'Test',
        price_cents: 10000,
        quantity: 5
      })
      @category = Category.new({
        name: 'Test'
      })
      @product.category = @category
      expect(@product.valid?).to be true
    end

    it "has a name" do
      @product = Product.new
      @product.name = nil
      @product.valid?
      expect(@product.errors[:name]).to include("can't be blank")
  
      @product.name = 'test'
      @product.valid? 
      expect(@product.errors[:name]).not_to include("can't be blank")
    end

    it "has a price" do
      @product = Product.new
      @product.price_cents = nil
      @product.valid?
      expect(@product.errors[:price_cents]).to include("is not a number")
  
      @product.price_cents = 10000
      @product.valid? 
      expect(@product.errors[:price_cents]).not_to include("can't be blank")
    end
  
    it "has a quantity" do
      @product = Product.new
      @product.quantity = nil 
      @product.valid?
      expect(@product.errors[:quantity]).to include("can't be blank")
  
      @product.quantity = 5
      @product.valid? 
      expect(@product.errors[:quantity]).not_to include("can't be blank")
    end
  
    it "has a category id" do
      @category = Category.new
      @product = Product.new
      @product.category = nil 
      @product.valid?
      expect(@product.errors[:category]).to include("can't be blank")

      @product.category = @category
      @product.valid? 
      expect(@product.errors[:category]).not_to include("can't be blank")
    end
  end
end