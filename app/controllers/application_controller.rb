class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :check_user_active
  helper_method :namespace, :to_currency
  
  def to_currency amount, currency='USD'
    ActionController::Base.helpers.number_to_currency amount, unit: currency, precision: 2, delimiter: '.', separator: ',', format: '%n %u'
  end
  
  def namespace
    names = self.class.to_s.split('::')
    return "null" if names.length < 2
    names[0..(names.length-2)].map(&:downcase).join('_')
  end
  
  def check_user_active
    authenticate_user!
    sign_out current_user if current_user and current_user.admin? == false
  end
  
end
