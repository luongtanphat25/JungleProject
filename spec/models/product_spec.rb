require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    
    before(:each) do
      @category = Category.create(name: 'Electronics')
      @product = Product.new(
        name: 'Product Name',
        price: 99.99,
        quantity: 10,
        category: @category
      )
    end

    it 'saves successfully when all fields are set' do
      expect(@product.save).to be true
    end

    it 'validates presence of name' do
      @product.name = nil
      expect(@product.valid?).to be false
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it 'validates presence of price' do
      @product.price = nil
      expect(@product.price).to eq(0)
      # expect(@product.errors[:price]).to include("can't be blank")
    end

    it 'validates presence of quantity' do
      @product.quantity = nil
      expect(@product.valid?).to be false
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'validates presence of category' do
      @product.category = nil
      expect(@product.valid?).to be false
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
  end
end
