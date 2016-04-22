class PostsController < ApplicationController
  #helper_method :params

  def index
    #raise params.inspect
    @posts = Post.all
    @authors = Author.all

    if !params[:author].blank?
      # if filter by author, return posts with that author
      @posts = Post.by_author(params[:author])
    elsif !params[:date].blank?
      #if filter by date
      if params[:date] == "Today"
        #return posts from today
        @posts = Post.from_today
      else
        #return posts from before today
        @posts = Post.old_news
      end
    else
      # if not filters, show them all
      @posts = Post.all
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params)
    @post.save
    redirect_to post_path(@post)
  end

  def update
    @post = Post.find(params[:id])
    @post.update(params.require(:post))
    redirect_to post_path(@post)
  end

  def edit
    @post = Post.find(params[:id])
  end
end
