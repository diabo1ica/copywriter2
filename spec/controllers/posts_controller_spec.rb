require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:user) { create(:user) }
  let(:sample_post) { create(:post, user: user) }  # Renamed from `post` to `sample_post`

  before do
    sign_in user # Assuming Devise for authentication
  end

  describe 'GET #index' do
    it 'assigns @posts' do
      get :index
      expect(assigns(:posts)).to eq([sample_post])
    end

    it 'renders the :index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #new' do
    it 'assigns a new Post to @post' do
      get :new
      expect(assigns(:post)).to be_a_new(Post)
    end

    it 'renders the :new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    let(:valid_attributes) { { content: 'New post content' } }
    let(:invalid_attributes) { { content: '' } }

    context 'with valid attributes' do
      it 'creates a new post' do
        expect {
          post :create, params: { post: valid_attributes }
        }.to change(Post, :count).by(1)
      end

      it 'redirects to the edit post page' do
        post :create, params: { post: valid_attributes }
        expect(response).to redirect_to(edit_post_path(assigns(:post)))
      end

      it 'sets the title based on content' do
        post :create, params: { post: valid_attributes }
        expect(assigns(:post).title).not_to be_empty
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new post' do
        expect {
          post :create, params: { post: invalid_attributes }
        }.to_not change(Post, :count)
      end

      it 're-renders the :new template' do
        post :create, params: { post: invalid_attributes }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested post to @post' do
      get :edit, params: { id: sample_post.id }
      expect(assigns(:post)).to eq(sample_post)
    end

    it 'renders the :edit template' do
      get :edit, params: { id: sample_post.id }
      expect(response).to render_template(:edit)
    end
  end

  describe 'PATCH #update' do
    let(:new_attributes) { { content: 'Updated post content' } }
    let(:invalid_attributes) { { content: '' } }

    context 'with valid attributes' do
      it 'updates the requested post' do
        patch :update, params: { id: sample_post.id, post: new_attributes }
        sample_post.reload
        expect(sample_post.content.to_plain_text).to eq('Updated post content')
      end

      it 'redirects to the index page' do
        patch :update, params: { id: sample_post.id, post: new_attributes }
        expect(response).to redirect_to(posts_path)
      end
    end

    context 'with invalid attributes' do
      it 'does not update the post' do
        patch :update, params: { id: sample_post.id, post: invalid_attributes }
        sample_post.reload
        expect(sample_post.content.to_plain_text).to eq('Sample post content')
      end

      it 're-renders the :edit template' do
        patch :update, params: { id: sample_post.id, post: invalid_attributes }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'GET #show' do
    it 'assigns the requested post to @post' do
      get :show, params: { id: sample_post.id }
      expect(assigns(:post)).to eq(sample_post)
    end

    it 'renders the :show template' do
      get :show, params: { id: sample_post.id }
      expect(response).to render_template(:show)
    end
  end
end
