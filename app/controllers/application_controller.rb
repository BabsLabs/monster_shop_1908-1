class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :cart,
                :current_user,
                :current_merchant_employee?,
                :current_merchant_admin?,
                :current_admin?,
                :above_average_user?

  def cart
    @cart ||= Cart.new(session[:cart] ||= Hash.new(0))
  end

  def current_user
    @user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_merchant_employee?
    current_user && current_user.merchant_employee?
  end

  def current_merchant_admin?
    current_user && current_user.merchant_admin?
  end

  def current_admin?
    current_user && current_user.admin?
  end

  def above_average_user?
    current_merchant_employee? || current_merchant_admin? || current_admin?
  end

end