class Lesson < ActiveRecord::Base
  
  belongs_to :lesson_level
  
  has_many :users
  has_many :books, as: :authority
  
  ### Deprecated from migration 20180320234607 ###
  has_many :lesson_audios
  
  has_many :audios, as: :audiable
  
  ### Deprecated from migration 20180321172731 ###
  has_many :lesson_videos
  
  
  has_many :videos, as: :videable
  
  validates :name, uniqueness: true
  
  def to_s
    name
  end
  
  def lesson_book
    book = Book.where(title: name).first
    book = Book.where(title: "La Búsqueda").first if book.nil?
    return book
  end
  
  def self.last_lesson
    Lesson.order(number: :desc).first
  end
  
  def next_lesson
    Lesson.where(number: (self.number == 24 ? self.number + 2 : self.number + 1)).first
  end
end