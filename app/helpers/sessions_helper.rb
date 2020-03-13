module SessionsHelper
  def current_user
    nil unless session[:user_id]
    # @current_userに何も代入されていないなら、find_byする(不要なDB問い合わせを避ける)
    @current_user ||= User.find_by(id: session[:user_id])
  end
end
