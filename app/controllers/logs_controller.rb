class LogsController < ApplicationController
  before_action :load_files

  def index
  end

  def show
    if params[:dl].present?
      render file: @files[params[:id].to_i], content_type: "application/rss"
    else
      render file: @files[params[:id].to_i], content_type: "text", layout: nil
    end
  end

  private
  def load_files
    @files = Dir[Rails.root + "log/*"]
  end
end