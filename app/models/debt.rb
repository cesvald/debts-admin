class Debt < ActiveRecord::Base
  belongs_to :item
  belongs_to :debable, polymorphic: true
  
  validates :amount, presence: true
  validates :registered_at, presence: true
  validates :item, presence: true
  validates :debable, presence: true
  
  after_create :sum_total_debt
  after_destroy :less_total_debt
  
  scope :by_headquarter_id, ->(headquarter_id) { joins(:item).where('items.headquarter_id = ?',  headquarter_id) }
  scope :covered, ->(covered) { where(covered: covered) }
  
  def sum_total_debt
    debable.total_debt = debable.total_debt + amount
    debable.save!
  end
  
  def less_total_debt
    debable.total_debt = debable.total_debt - amount
    debable.save!
  end
  
end
