class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  
  #the find_or_initialize_by_id method wasn't working. Change to '_by:(id: session ...)'
    def load_order
      # @order = Order.find_or_initialize_by(id: session[:order_id], status: "unsubmitted", user_id: session[:user_id])
      # needed to update to use create_with ... 
      @order = Order.create_with(user_id: session[:user_id]).find_or_initialize_by(id: session[:order_id], status: "unsubmitted")
      if @order.new_record?
        @order.save!
        session[:order_id] = @order.id
      end
    end
  
  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
