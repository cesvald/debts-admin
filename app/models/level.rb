class Level < ActiveRecord::Base
    require "unicode_utils/upcase"
    
    ### Deprecated from migration 20180320234607 ###
    has_many :level_audios, -> { order(:number) }
    
    has_many :audios, -> { order('number asc') }, as: :audiable
    
    ### Deprecated from migration 20180321172731 ###
    has_many :level_videos
    
    has_many :videos, -> { order('number asc') }, as: :videable
  
    has_many :main_pages
    
    has_many :users
    
    has_many :books, as: :authority
    
    has_and_belongs_to_many :users
    
    scope :by_priority, -> (priority) { where("priority = :priority", {priority: priority}) }
    scope :number_less_than, -> (number) { where("number < :number", {number: number}) }
    scope :number_greater_or_equal_to, -> (number) { where("number >= :number", {number: number}) }
    validates :name, uniqueness: true
    validates_presence_of :name
    
    def to_s
        name
    end
    
    def book_name
        I18n.transliterate("#{name.split(" ").first}".downcase)
    end
    
    def display_book_name
        name.split(" ").first.downcase
    end
    
    def only_level
        name.split(" ").first
    end
    
    def book_number
        "#{name.split(" ").last}"
    end
        
    def name_upcase
        UnicodeUtils.upcase(name)
    end
    
    def next_level
        Level.where(number: number + 1).first
    end
    
    def self_value
        value + "se"
    end
    
    def level_book
        books.where(title: name).first
    end
    
    def emanation_book
        books.where(title: "Emanaciones " + name).first
    end
    
    def array_front_sections
        level_book.sections.where("main_number IS NOT NULL").order(main_number: :asc).to_a
    end
    
    def complementary_book
        number == 2 ? books.where(title: "Fuego Sagrado").first : nil
    end
    
    def self.last_book_I
        Level.where(priority: 1).order(number: :desc).first
    end
    
    def self.last_book_II
        Level.where(priority: 2).order(number: :desc).first
    end
    
    def next_level
        Level.where("number > :number AND priority = :priority", {number: self.number, priority: self.priority}).order(number: :asc).first
    end
    
    def self.first_level_two
        Level.where(priority: 2).order(number: :asc).first
    end
    
    def self.swamis
        Level.where(number: 108).first
    end
    
end