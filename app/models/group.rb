class Group < ActiveRecord::Base
  belongs_to :headquarter
  belongs_to :user
  has_many :users
  
  scope :outside, -> { where(is_outside: true) }
  scope :onsite, -> { where(is_outside: false) }
  
  def to_s
    name
  end
end