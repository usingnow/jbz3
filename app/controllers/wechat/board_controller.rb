class Wechat::BoardController < ApplicationController
  layout 'wechat'

  def index
    #TODO: 暂时只有4个sku，没有必要分页。如果sku数量增加，需要考虑分页和首页sku挑选。
    @jbz_skus = JbzSku.all
  end

  def jbz_cover
    
  end

  def legal_announcement

  end
end
