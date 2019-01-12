class Debt < ActiveRecord::Base
  belongs_to :item
  belongs_to :debable, polymorphic: true
  
  validates :amount, presence: true
  validates :registered_at, presence: true
  validates :item, presence: true
  validates :debable, presence: true
  validate :unique_item_registered_at_same_debable
  
  after_create :sum_total_debt
  after_destroy :less_total_debt
  
  scope :by_headquarter_id, ->(headquarter_id) { joins(:item).where('items.headquarter_id = ?',  headquarter_id) }
  scope :covered, ->(covered) { where(covered: covered) }
  
  def unique_item_registered_at_same_debable
     errors.add(:unique_item_and_registered_at, "Ya hay una deuda con el mismo concepto en la misma fecha") unless debable.debts.where(item: item, registered_at: registered_at).first.nil?
  end
  
  def sum_total_debt
    debable.total_debt = debable.total_debt + amount
    debable.save!
  end
  
  def less_total_debt
    debable.total_debt = debable.total_debt - amount
    debable.save!
  end
  
end
