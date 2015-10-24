class Address < ActiveRecord::Base
    has_many :orders
    belongs_to :user
    
    validates :zip, presence: true, length: {is: 5}, numericality: true
    validates :state, presence: true, format: { with: /\A[A-Z][A-Z]\z/}
    validates :line1, presence: true
    validates :city, presence: true
    validates :user_id, presence: true
    
    def to_s
        #build an array of the attributes you want to display, then join them together with a comma and a space.
        #compact gets rid of nil items in array
        [line1, line2, city, state, zip].compact.join(", ")
        [line1, line2, city, state, zip].reject(&:blank?).join(", ")
    end
    
end
