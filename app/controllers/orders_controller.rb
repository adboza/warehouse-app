class OrdersController < ApplicationController
  
  def index
    @orders = current_user.orders
  end

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
      @warehouses = Warehouse.all
      @suppliers = Supplier.all
      flash.now[:notice] = 'Não foi possível registrar o pedido'
      render 'new'
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  def search
    @code = params["query"]    
    @orders = Order.where("code LIKE ?", "%#{@code}%")
    #@order = Order.find_by(code: params['query'])
  end
end