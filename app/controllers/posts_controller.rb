class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :find_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def show
  end

  def new
    @post = Post.new
  end

  def edit
    if @post.user != current_user
      redirect_to post_path(@post), alert: "不正なアクセスです"
    end
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post), notice: "投稿完了です！"
    else
      render :new
    end
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "投稿を更新しました！"
    else
      render :edit
    end
  end

  def destroy
    if @post.destroy
      redirect_to root_path, notice: "投稿を削除しました！"
    else
      redirect_to root_path, alert: "投稿を削除できませんでした。。"
    end
  end

  private
  def find_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :address, :content, images:[])
  end
end
