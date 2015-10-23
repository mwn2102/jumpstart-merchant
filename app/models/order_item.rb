class OrderItem < ActiveRecord::Base
    validates :order_id, :product_id, presence: true
    validates :quantity, numericality: {only_integer: true, greater_than: 0}
    
    
    belongs_to :order
    belongs_to :product
    
    def subtotal
        self.quantity * self.product.price
    end
end
