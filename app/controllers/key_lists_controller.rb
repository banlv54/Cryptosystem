class KeyListsController < ApplicationController
  # require 'htmlentities'

  def index
    @list_paths = [
      :key_single,
      :key_pair,
      :key_triple,
      :key_quadruple,
      :key_pentum
    ]
  end

  def show_list
    @q = params[:model_name].classify.constantize.ransack(params[:q])
    @keys = @q.result.paginate(page: params[:page], per_page: 20)
  end
end
