class KittensController < ApplicationController
  before_action :set_kitten, only: [:show, :edit, :update, :destroy]

  def index
    @kittens = Kitten.all
  end

  def show
  end

  def new
    @kitten = Kitten.new
  end

  def create
    @kitten = Kitten.new(kitten_params)
    if @kitten.save
      flash[:success] = "Kitten created!"
      redirect_to kitten_path(@kitten)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @kitten.update(kitten_params)
      flash[:success] = "Kitten updated!"
      redirect_to kitten_path(@kitten)
    else
      render :edit
    end
  end

  def destroy
    @kitten.destroy
    flash[:success] = "Kitten deleted!"
    redirect_to root_path
  end

  private

    def kitten_params
      params.require(:kitten).permit(:name, :age, :cuteness, :softness)
    end

    def set_kitten
      unless (@kitten = Kitten.find_by(id: params[:id]))
        flash[:danger] = "Invalid kitten id."
        redirect_to root_path
      end
    end
end
