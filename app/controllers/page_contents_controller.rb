class PageContentsController < ApplicationController
  def index
    @per_page = 30
    @page_contents = PageContent.order(created_at: :desc).paginate(page: params[:page], per_page: @per_page)
  end

  def new
    @page_content = PageContent.new
  end

  def create
    PageContent.import_database params[:link], params[:start_id].to_i, params[:end_id].to_i
    redirect_to page_contents_path
  end

  def show
    @page_content = PageContent.find params[:id]
  end
end
