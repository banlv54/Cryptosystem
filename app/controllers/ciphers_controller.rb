class CiphersController < ApplicationController
  def index
    @cipher = Cipher.new
  end

  def create
    @cipher = Cipher.new cipher_params
    if @cipher.save
      redirect_to root_path(notice: true)
    else
      redirect_to root_path(notice: false)
    end
  end

  def show
  end

  private
  def cipher_params
    params.require(:cipher).permit Cipher::DEFAULT_ATTRIBUTES
  end
end
