class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_post, only: [:show, :edit, :update]

  include PostsHelper

  # Landing page
  def index
    if user_signed_in?
      @posts = current_user.posts
    end
  end

  # Load the form
  def new
    @post = Post.new
  end

  # Call OpenAI API and save the content 
  def create
    @post = current_user.posts.build(post_params)

    # Generate enhanced content using GPT-4 mini service
    gpt_service = GptService.new(@post.content)
    @post.enhanced = gpt_service.generate_content

    @post.title = extract_title(post_params[:content])

    if @post.save
      redirect_to edit_post_path(@post), notice: 'Post was successfully created.'
    else
      render :new
    end

  end
  
  def edit

  end
  
  # Update the selected form
  def update
    if @post.update(patch_post_params)
      redirect_to posts_path, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end
  
  def show
    @post = Post.find(params[:id])
  end

  private

  # Required to edit existing post
  def set_post
    @post = current_user.posts.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:content)
  end

  def patch_post_params
    params.require(:post).permit(:content, :enhanced)
  end

end
