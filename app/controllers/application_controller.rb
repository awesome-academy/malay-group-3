class ApplicationController < ActionController::Base
  include SessionsHelper
  
  before_action :switch_locale

  private
  
  def default_url_options
    {locale: I18n.locale}
  end

  def switch_locale
    I18n.locale = extract_locale || I18n.default_locale
  end

  def extract_locale
    parsed_locale = params[:locale]
    I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
  end
end
