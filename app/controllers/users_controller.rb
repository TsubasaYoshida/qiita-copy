class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  skip_before_action :check_logged_in, only: [:show, :new, :create]

  def show
  end

  def new
    @user = User.new
  end

  def edit
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

  def update
    if @user.update(user_params)
      redirect_to edit_user_url @user, notice: 'プロフィール情報の編集が完了しました。'
    else
      render :edit
    end
  end

  def destroy
    reset_session
    @user.destroy
    redirect_to '/', notice: '退会処理が完了しました。'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:screen_name, :email, :password)
  end
end
