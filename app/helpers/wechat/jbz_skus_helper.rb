module Wechat::JbzSkusHelper
  def underwrite_age(starts_at, ends_at)
    starts_at.to_s + '-' + ends_at.to_s + '周岁'
  end
end
