class OrdersController < ApplicationController
  def new
    @order = Order.new
    @suppliers = Supplier.all
    @warehouses = Warehouse.all
  end

  def create
    order_params = params.require(:order).permit(:warehouse_id, :supplier_id, :estimated_delivery_date, :code)
    @order = Order.new(order_params)
    @order.user = current_user
    
    if @order.save
      redirect_to @order, notice: 'Pedido registrado com sucesso'
    else
      #@suppliers = Supplier.all
      flash.now[:notice] = 'Não foi possível registrar o pedipt'
      render 'new'
    end
  end

  def show
    @order = Order.find(params[:id])
  end
end