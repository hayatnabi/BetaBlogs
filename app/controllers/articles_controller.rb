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

  def index
    # index action which expects index.html.erb under views/articles folder
    @articles = Article.all
  end

  def new
    # new action expects new.html.erb file under views/acticles folder as RoR convention of MVC pattern
    @article = Article.new
  end

  def create
    # using require and permit because rails provide a feature of strong parameters which means only those attributes / keys will be allowed that are permitted
    @article = Article.new(params.require(:article).permit(:title, :description))
    if @article.save
      flash[:notice] = "Article created successfully!"
      redirect_to @article # shorthand syntax for redirecting to the article_path
    else
      # handle if save is failed.
      render :new, status: :unprocessable_entity  # or render 'new'
    end
  end
end
