class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = current_user.posts
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

    # Generate enhanced content using GPT-3 service
    gpt_service = GptService.new(@post.content)
    @post.enhanced = gpt_service.generate_content

    Rails.logger.debug("Post Object: #{@post.inspect}")
    Rails.logger.debug("Enhanced Content: #{@post.enhanced.inspect}")
    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      Rails.logger.error(@post.errors.full_messages)
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
