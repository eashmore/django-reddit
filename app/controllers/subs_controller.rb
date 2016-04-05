class SubsController < ApplicationController
  before_action :require_signed_in!, only: [:show, :index, :new, :create]
  before_action :require_ownership!, only: [:edit, :update]

  def index
    @subs = Sub.all
    render :index
  end

  def new
    @sub = Sub.new
    render :new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id
    if @sub.save
      redirect_to @sub
    else
      render :new
    end
  end

  def show
    @sub = Sub.find(params[:id])
    render :show
  end

  def edit
    @sub = Sub.find(params[:id])
    render :edit
  end

  def update
    @sub = Sub.find(params[:id])
    if @sub.update(sub_params)
      redirect_to @sub
    else
      render :edit
    end
  end

  private

  def require_ownership!
    return if Sub.find(params[:id]).moderator == current_user
    render json: 'Forbidden', status: :forbidden
  end

  def sub_params
    params.require(:sub).permit(:title, :description, :moderator_id, :sub_ids)
  end
end
