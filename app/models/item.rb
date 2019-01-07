class Item < ActiveRecord::Base
    belongs_to :headquarter
    has_many :debts
    
    scope :by_headquarter_id, ->(headquarter_id) { where( 'headquarter_id = :headquarter_id', headquarter_id: headquarter_id ) }
    scope :by_name, ->(name) { where( 'name ILIKE :name', {name: "%#{name}%"} ) }
    
    def to_s
        name
    end
end
