class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user, only: [:show, :edit, :update]

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to root_path, notice: "プロフィール情報を更新しました"
    else
      render :edit
    end
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def users_params
    params.require(:user).permit(:username, :profile)
  end
end
