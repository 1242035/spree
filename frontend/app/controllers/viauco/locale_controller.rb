module Viauco
  class LocaleController < Viauco::StoreController
    def set
      session['user_return_to'] = request.referer if request.referer&.starts_with?('http://' + request.host)
      if params[:locale] && I18n.available_locales.map(&:to_s).include?(params[:locale])
        session[:locale] = I18n.locale = params[:locale]
        flash.notice = Viauco.t(:locale_changed)
      else
        flash[:error] = Viauco.t(:locale_not_changed)
      end
      redirect_back_or_default(viauco.root_path)
    end
  end
end
