class ArticlesController < ApplicationController
	before_filter :authenticate_user!
	def index
		@articles = Article.page(params[:page]).per(10)
	end

	def show
		@article = Article.find(params[:id])
		@comments = @article.comment
	end

	def new
		@article = Article.new
	end

	def edit
		@article = Article.find(params[:id])
	end

	def create
		@article = Article.new(params[:article])
		if @article.save
			flash[:notice] = "Create new Article Successfully"
			redirect_to :action => :index
		else
			render :action => :new
		end
	end

	def update
			@article = Article.find(params[:id])
			if @article.update_attributes (params[:article])
			flash[:notice] = "Update Article Successfully"
			redirect_to :action => :index
		else
			render :action => :new
		end
	end

	def destroy
		@article = Article.find(params[:id])
    	@article.destroy
    	redirect_to articles_path
	end

end
