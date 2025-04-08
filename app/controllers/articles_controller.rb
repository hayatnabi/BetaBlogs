class ArticlesController < ApplicationController
  def show
    begin
      @article = Article.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      @message = "Article not found"
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("flash", partial: "shared/not_found", locals: { message: @message }) }
        format.html { render partial: "shared/not_found", status: :not_found }
      end
    end
  end
end
