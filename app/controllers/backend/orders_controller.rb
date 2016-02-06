class Backend::OrdersController < ApplicationController
  layout 'backend'



  def index
    @orders = Order.all.paginate(:page => params[:page], :per_page => 10)
  end

  private
    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:name, :creditcard_num, :email, :cellphone, :address, :id_card, :ref, :dynamic_key, :bank, :debitcard_num)
    end
end
