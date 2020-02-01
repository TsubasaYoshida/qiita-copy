module SessionsHelper

  def current_user
    # このif文は、無駄なfind_byを無くすため(不要なDB問い合わせを避ける)
    if session[:user_id]
      # @current_userに何も代入されていないなら、find_byする(不要なDB問い合わせを避ける)
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  def current_user_url
    "/#{current_user.screen_name}"
  end
end
