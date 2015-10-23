class OrderItemsController < ApplicationController
  before_action :load_order, only: [:create]
  before_action :set_order_item, only: [:show, :edit, :update, :destroy]

  # GET /order_items
  # GET /order_items.json
  # def index
  #   @order_items = OrderItem.all
  # end

  # GET /order_items/1
  # GET /order_items/1.json
  # def show
  # end

  # GET /order_items/new
  # def new
  #   @order_item = OrderItem.new
  # end

  # GET /order_items/1/edit
  def edit
  end

  # POST /order_items
  # POST /order_items.json
  def create
    # These are the different iterations we've gone through
    # @order_item = OrderItem.new(order_item_params)
    # @order_item = OrderItem.new(product_id: params[:product_id], order_id: @order.id)
    # @order_item = @order.order_items.new(quantity: 1, product_id: params[:product_id])
    # used below instead of .find_or_initialize_by_product_id(params[:product_id])
    @order_item = @order.order_items.find_or_initialize_by(product_id: params[:product_id])
    @order_item.quantity += 1
  
    respond_to do |format|
      if @order_item.save
        format.html { redirect_to @order, notice: 'Successfully added product to cart.' }
        format.json { render :show, status: :created, location: @order_item }
      else
        format.html { render :new }
        format.json { render json: @order_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /order_items/1
  # PATCH/PUT /order_items/1.json
  def update
    if params[:order_item][:quantity].to_i == 0
      @order_item.destroy
      redirect_to order_path(session[:order_id])
      flash[:notice] = 'Order item was successfully removed.' 
    elsif @order_item.update(order_item_params)
      redirect_to order_path(session[:order_id])
      flash[:notice] = 'Order item was successfully updated.' 
    else
      render :edit
    end
      
    # respond_to do |format|
    #   if @order_item.update(order_item_params)
    #     format.html { redirect_to order_path(session[:order_id]), notice: 'Order item was successfully updated.' }
    #     format.json { render :show, status: :ok, location: @order_item }
    #   else
    #     format.html { render :edit }
    #     format.json { render json: @order_item.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # DELETE /order_items/1
  # DELETE /order_items/1.json
  def destroy
    @order_item.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Order item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  
    # def load_order
    #   begin
    #     @order = Order.find(session[:order_id])
    #   rescue ActiveRecord::RecordNotFound
    #     @order = Order.create(status: "unsubmitted")
    #     session[:order_id] = @order.id
    #   end
    # end
    
    #removed finding by id and the order status
    # def load_order
    #   @order = Order.find_or_initialize_by(session[:order_id])
    #   if @order.new_record?
    #     @order.save!
    #     session[:order_id] = @order.id
    #   end
    # end
  
    # Use callbacks to share common setup or constraints between actions.
    def set_order_item
      @order_item = OrderItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_item_params
      params.require(:order_item).permit(:product_id, :order_id, :quantity)
    end
end
