class Ability
  include CanCan::Ability

  def initialize(current_user, options = {})
    current_user ||= User.new
    
    if current_user.admin?
        can :manage, :all
    end
    
    if current_user.acom?
        can :manage, User
    end
    if current_user.coor?
        can :manage, Group do
          current_user.group.headquarter == group.headquarter
        end
        can :manage, User
        can :manage, Profile
    end
    if current_user.maint?
      can :manage, LiveLink
    end
    can :read, Album
    can :read, Photo
    can :read, Lesson do |lesson|
        current_user.lesson.number >= lesson.number
    end
    can :read, LessonLevel do |lesson_level|
        current_user.lesson.lesson_level.id >= lesson_level.id
    end
    can :read, Level do |level|
      if current_user.last_level.number >= level.number
        true
      elsif level.number == 108 && current_user.swami?
        true
      else
        false
      end
    end
    can :read, Audio do |audio|
      if not audio.last_level.nil?
        current_user.last_level.number >= audio.level.number
      elsif not audio.lesson.nil?
        current_user.lesson.number >= audio.lesson.number
      elsif not audio.auth_level.nil?
        current_user.last_level.number >= audio.auth_level
      else
        true
      end
    end
    
    can :read, Book
    
    can :read, Notification
    
  end
  
end
