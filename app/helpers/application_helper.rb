module ApplicationHelper

  def subtotal(p, q)
    p * q
  end

  def to_money(amount)
    number_to_currency(amount, unit: "￥")
  end
end
