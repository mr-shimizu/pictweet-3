require 'rails_helper'

describe TweetsController do

  describe 'GET #new' do
    it "renders the :new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    it "assigns the requested tweet to @tweet" do
      tweet = create(:tweet)
      get :edit, id: tweet
      expect(assigns(:tweet)).to eq tweet
    end

    it "renders the :edit template" do
      tweet = create(:tweet)
      get :edit id :tweet
      expect(resoponse).to render_template :edit
    end
  end

  describe 'GET #index' do
    end
  end
end
