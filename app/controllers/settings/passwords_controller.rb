class Settings::PasswordsController < ApplicationController
  before_action :set_current_user, only: %i(edit update)

  def edit
  end

  def update
    # updateはcontextを引数に取れないため、attributesとsaveを使う
    @user.attributes = user_params
    if @user.save(context: :password_reset)
      redirect_to edit_settings_password_url, notice: 'パスワードを更新しました。'
    else
      render :edit
    end
  end

  private

  def set_current_user
    # @user = current_user だとビューでcurrent_userを使うとき、@userの内容を参照してしまうためNG
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:password, :old_password)
  end
end
