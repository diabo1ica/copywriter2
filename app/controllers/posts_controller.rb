class PostsController < ApplicationController

  def index
    
  end

  def new
    @post = Post.new
  end

  def create
    # current_user:
    # This is a method provided by Devise that returns the currently logged-in user. 
    # It’s available in your controllers and allows you to access the user who is currently authenticated.
    # .posts:
    # This leverages the has_many association defined in the User model. 
    # It returns an ActiveRecord::Relation representing all the posts associated with the current user. 
    # In other words, it gives you a collection of posts that belong to the currently logged-in user.
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end

end
