class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update]

  include PostsHelper

  def index
    @posts = current_user.posts
  end

  def new
    @post = Post.new
  end

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
  
  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end
  
  def show
    @post = Post.find(params[:id])
  end

  private

  def set_post
    @post = current_user.posts.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:content)
  end

end
