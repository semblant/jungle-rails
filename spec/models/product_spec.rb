require 'rails_helper'

RSpec.describe Product, type: :model do
  describe "validations" do
    it "should be valid with only necessary attributes" do
      category = Category.create!(name: "Pothos")
      product = Product.new(
        name: "Golden Pothos",
        price_cents: 2958,
        quantity: 7,
        category_id: category.id
        )

      expect(product).to be_valid
    end

    it "is invalid without a name" do
      category = Category.create!(name: "Pothos")
      product = Product.new(
        name: nil,
        price_cents: 2958,
        quantity: 7,
        category_id: category.id
      )

      expect(product).not_to be_valid
      expect(product.errors.full_messages).to include("Name can't be blank")
    end

    it "is invalid without a price" do
      category = Category.create!(name: "Pothos")
      product = Product.new(
        name: "Golden Pothos",
        price_cents: nil,
        quantity: 7,
        category_id: category.id
        )
      expect(product).not_to be_valid
      expect(product.errors.full_messages).to include("Price is not a number")
    end

    it "is invalid without a quantity" do
      category = Category.create!(name: "Pothos")
      product = Product.new(
        name: "Golden Pothos",
        price_cents: 2958,
        quantity: nil,
        category_id: category.id
        )
      expect(product).not_to be_valid
      expect(product.errors.full_messages).to include("Quantity can't be blank")
    end

    it "is invalid without a category" do
      category = Category.create!(name: "Pothos")
      product = Product.new(
        name: "Golden Pothos",
        price_cents: 2958,
        quantity: 7,
        category_id: nil
        )
      expect(product).not_to be_valid
      expect(product.errors.full_messages).to include("Category must exist")
    end
  end
end
