class UsersController < ApplicationController
  skip_before_action :check_logged_in, only: [:show, :new, :create]

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      # セッション固定攻撃への対策
      reset_session
      session[:user_id] = @user.id
      redirect_to home_index_url, notice: 'ユーザー登録が完了しました。'
    else
      render :new
    end
  end

  def destroy
    current_user.destroy
    reset_session
    redirect_to '/', notice: '退会処理が完了しました。'
  end

  private

  def user_params
    params.require(:user).permit(:screen_name, :email, :password)
  end
end
