class Discount < ActiveRecord::Base
    belongs_to :discountable, polymorphic: true
    belongs_to :headquarter
end
