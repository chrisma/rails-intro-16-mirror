class PapersController < ApplicationController
  before_action :set_paper, only: [:show, :edit, :update, :destroy]

  def index
    @papers = Paper.all
  end

  def show
  end

  def new
    @paper = Paper.new
    build_empty_authors
  end

  def edit
    build_empty_authors
  end

  def create
    unify_author_params
    @paper = Paper.new(paper_params)
    if @paper.save
      redirect_to papers_path, notice: 'Paper was successfully created.'
    else
      build_empty_authors
      render :new
    end
  end

  def update
    unify_author_params
    if @paper.update(paper_params)
      redirect_to @paper, notice: 'Paper was successfully updated.'
    else
      build_empty_authors
      render :edit
    end
  end

  def destroy
    @paper.destroy
    redirect_to papers_url, notice: 'Paper was successfully destroyed.'
  end

  private
    def set_paper
      @paper = Paper.find(params[:id])
    end

    def paper_params
      params.require(:paper).permit(:title, :venue, :year, :authors, :author_ids => [])
    end

    def build_empty_authors
#      (5-@paper.authors.length).times do
#        @paper.authors.build
#      end
    end

    def unify_author_params
#      params[:paper][:author_ids] = params[:paper][:author_ids].uniq
    end
end
