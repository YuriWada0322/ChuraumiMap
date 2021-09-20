class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :find_user, only: [:show, :edit, :update]

  def show
  end

  def edit
    if @user != current_user
      redirect_to users_path, alert: "不正なアクセスです"
    end
  end

  def update
    if @user.update(user_params)
      redirect_to user_path, notice: "プロフィール情報を更新しました"
    else
      render :edit
    end
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :profile, image:[])
  end
end
