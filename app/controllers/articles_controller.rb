class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def index
    @articles = Article.all
  end

  def show;
  end

  def new
    @article = Article.new
  end

  def edit;
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      @article.create_attachments
      redirect_to root_path
    else
      render :new
    end
  end

  def update
    if @article.update(article_params)
      @article.create_attachments
      redirect_to @article, notice: 'Article was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @article.destroy!
    redirect_to articles_url, notice: 'Article was successfully destroyed.'
  end

  def upload
    file = params[:file]
    @blob = ActiveStorage::Blob.create_after_upload!(io: file, filename: file.original_filename)
    render json: {filename: @blob.signed_id}
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end


  def article_params
    params.require(:article).permit(:title, :body, images: [])
  end
end
