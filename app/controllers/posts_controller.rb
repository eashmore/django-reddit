class PostsController < ApplicationController
  before_action :require_signed_in!, only: [:new, :create]
  before_action :require_ownership!, only: [:edit, :update]

  def new
    @post = Post.new
    render :new
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    if @post.save
      redirect_to @post.sub
    else
      render @post.sub
    end
  end

  def show
    @post = Post.find(params[:id])
    render :show
  end

  def edit
    @post = Post.find(params[:id])
    render :edit
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to @post
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    sub = @post.sub
    @post.destroy
    redirect_to sub
  end

  private

  def require_ownership!
    return if Post.find(params[:id]).author == current_user
    redirect_to json: 'Forbidden', status: :forbidden
  end

  def post_params
    params.require(:post).permit(:title, :url, :content, :sub_id)
  end
end
