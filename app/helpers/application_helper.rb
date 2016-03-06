module ApplicationHelper

  def subtotal(p, q)
    p * q
  end

  def to_money(amount)
    number_to_currency(amount, unit: "￥")
  end

  def age_from_id_card_num(id_card_num)
    case id_card_num.size
    when 18 then
      age = Date.current.year - id_card_num.slice(6,4).to_i
    when 15 then
      age = Date.current.year - (1900 + id_card_num.slice(6,2).to_i)
    end
  end

  def birthday_from_id_card_num(id_card_num)
    case id_card_num.size
    when 18 then
      birthday = id_card_num.slice(6,8).to_date.to_formatted_s(:db)
    when 15 then
      birthday = ("19" + id_card_num.slice(6,6)).to_date.to_formatted_s(:db)
    end
  end

  def gender_from_id_card_num(id_card_num)
    case id_card_num.size
    when 18 then
      id_card_num.slice(-2,1).to_i.even? ? "女" : "男"
    when 15 then
      id_card_num.slice(-1,1).to_i.even? ? "女" : "男"
    end
  end

end
