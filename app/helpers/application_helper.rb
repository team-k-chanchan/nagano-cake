module ApplicationHelper

  def current_cart
    @cart_items = current_customer.cart_items
  end

  def tax_price(price)
    (price * 1.1).floor
  end
  
  def sub_price(sub)
      (tax_price(sub.item.price) * sub.quantity)
  end

  def total_price(totals)
    price = 0
    totals.each do |total|
      price  +=  sub_price(total)
    end
    return price
  end

  def billing(order)
    total_price(current_cart) + order.shipping_cost
  end

  def full_title(title = "")
    base_title = "NaganoCAKE"
    if admin_signed_in?
      base_title + "|" + "(管理者) #{title}"
    else
      base_title + "|" + "#{title}"
    end
  end

  def full_name(customer_id)
    customer = Customer.find_by(id: customer_id)
    customer.last_name + customer.first_name
  end

  def kana_full_name(customer)
    customer.kana_last_name + customer.kana_first_name
  end

  def order_address(order_id)
    order = Order.find_by(id: order_id)
    "〒#{order.postal_code}" + order.address
  end
end
