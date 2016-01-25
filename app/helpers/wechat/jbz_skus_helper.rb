module Wechat::JbzSkusHelper
  def underwrite_age(starts_at, ends_at)
    starts_at.to_s + '-' + ends_at.to_s + '周岁'
  end

  def redemption_period(period)
    case period
    when 0
      return '30天后'
    when 90
      return '90天后'
    when 180
      return '180天后'
    when 360
      return '360天后'
    end
  end
end
