class CommentsController < ApplicationController

    def show
        @comment = Comment.find(params[:id])    
    end

    def new
        @comment = Comment.new
    end

    def edit
        @comment = Comment.find(params[:id])
    end

    def create
        article = Article.where(:id => params[:comment][:article_id]).first
        @comment = article.comment.new(params[:comment])
        if @comment.save
            flash[:notice] = "Create new comment Successfully"
            redirect_to articles_path
        else
            redirect_to articles_path
        end
    end

    def update
      @comment = Comment.find(params[:id])
      if @comment.update_attributes (params[:comment])
        flash[:notice] = "Update comment Successfully"
        redirect_to :action => :index
      else
        render :action => :new
      end
    end

    def destroy
        @comment = Comment.find(params[:id])
        @comment.destroy
        redirect_to comments_path
    end
end
