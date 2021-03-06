class SessionsController < ApplicationController
  skip_before_action :check_logged_in, only: %i(new create)

  def new
    redirect_to :root if current_user
  end

  def create
    user = User.find_by_identity(session_params[:identity])
    if user&.authenticate(session_params[:password])
      reset_session
      session[:user_id] = user.id
      redirect_to :root, notice: 'ログインしました。'
    else
      flash.now[:error] = '入力値が誤っています。'
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to :root, notice: 'ログアウトしました。'
  end

  private

  def session_params
    params.require(:session).permit(:identity, :password)
  end
end
