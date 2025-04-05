require 'rails_helper'

RSpec.describe Product, type: :model do
  before(:each) do
    @category = Category.create!(name: "Pothos")
    @product = Product.new(
      name: "Golden Pothos",
      price_cents: 2958,
      quantity: 7,
      category_id: @category.id
      )
  end


  describe "validations" do
    it "should be valid with only necessary attributes" do
      expect(@product).to be_valid
    end

    it "is invalid without a name" do
      @product.name = nil
      expect(@product).not_to be_valid
      expect(@product.errors[:name]).to include("can't be blank")
    end

    it "is invalid without a price" do
      @product.price_cents = nil
      expect(@product).not_to be_valid
      expect(@product.errors[:price_cents]).to include("is not a number")
    end

    it "is invalid without a quantity" do
      @product.quantity = nil
      expect(@product).not_to be_valid
      expect(@product.errors[:quantity]).to include("can't be blank")
    end

    it "is invalid without a category" do
      @product.category = nil
      expect(@product).not_to be_valid
      expect(@product.errors[:category]).to include("must exist")
    end
  end
end
