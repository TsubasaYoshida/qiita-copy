class UsersController < ApplicationController
  skip_before_action :check_logged_in, only: [:show, :new, :create]
  before_action :set_current_user, only: [:profile, :profile_update]

  def show
    # ヒットしなかったら404にしたい
    # => find_by!を使用して、ActiveRecord::RecordNotFoundがraiseされるようにする
    @user = User.find_by!(screen_name: params[:screen_name])
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
      redirect_to :root, notice: 'ユーザー登録が完了しました。'
    else
      render :new
    end
  end

  def destroy
    current_user.destroy
    reset_session
    redirect_to '/', notice: '退会処理が完了しました。'
  end

  def profile
  end

  def profile_update
    if @user.update(user_params)
      redirect_to settings_profile_url, notice: 'プロフィールを更新しました。'
    else
      render :profile
    end
  end

  private

  def set_current_user
    # @user = current_user だとビューでcurrent_userを使うとき、@userの内容を参照してしまうためNG
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:screen_name, :email, :password)
  end
end
