require 'rails_helper'

RSpec.describe Order, type: :model do
  it { should belong_to(:user) }
  it { should respond_to(:items) }
  it { should respond_to(:order_items) }

  scenario "it can create order items" do
    order = Order.create
    item = Item.create(name: "thing", description: "great", price: "10")
    cart = Cart.new({ "#{item.id}" => 1 })

    order.create_order_items(cart)

    expect(OrderItem.count).to eq 1
    expect("thing").to eq(order.items.last.name)
  end

  scenario "it counts all with a given status" do
    orders = create_list(:order, 3)
    paid_order = create(:order, status: 1)
    cancelled_order = create(:order, status: 2)
    completed_order = create(:order, status: 3)

    expect(Order.total(0)).to eq 3
    expect(Order.total(1)).to eq 1
    expect(Order.total(2)).to eq 1
    expect(Order.total(3)).to eq 1
  end
end
