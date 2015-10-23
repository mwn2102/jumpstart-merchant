class Order < ActiveRecord::Base
    has_many :order_items, dependent: :destroy
    belongs_to :user
    
    def total
        sum = 0
        #could also use inject here
        self.order_items.each do |item|
            sum += item.subtotal
        end
        sum
    end
end
