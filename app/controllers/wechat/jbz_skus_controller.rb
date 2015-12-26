class Wechat::JbzSkusController < ApplicationController
  layout 'wechat'

  before_action :set_jbz_sku, only: [:show,]

  def show

  end

  private
    def set_jbz_sku
      @jbz_sku = JbzSku.find(params[:id])
    end

    def jbz_sku_params
      params.require(:jbz_sku).permit(:price, :original_price, :reward,
                                      :sales_volume)
    end
end
