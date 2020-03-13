class Settings::ProfilesController < ApplicationController
  before_action :set_current_user, only: %i(edit update)

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to edit_settings_profile_url, notice: 'プロフィールを更新しました。'
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
    params.require(:user).permit(:screen_name, :email)
  end
end
