class UserDecorator < Draper::Decorator
  decorates :user
  include Draper::LazyHelpers
  
  def display_coor_groups
    source.coor_groups.map(&:name).join(", ")
  end
  
  def display_pending_levels
    "Pendiente: #{source.pending_levels.map(&:name).join(', ')}" if not source.pending_levels.empty? 
  end
  
  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%e/%y")
  #     end
  #   end

end
