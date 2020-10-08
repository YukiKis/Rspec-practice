require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  include LoginHelper

  let(:user) { FactoryBot.create(:user, name: "Michael") }

  it "get new" do
    get :new
    expect(response.status).to eq(200)
  end

  it "store forwarding_url only at first" do
    redirect_to edit_user_path(user)
    expect(session[:forwarding_url]).to_not eq(edit_user_path(user))
    log_in_as(user)
    expect(session[:forwarding_url]).to be_nil
  end

  it "get root" do
    get :home
    expect(response.status).to eq(200)
    expect(response.body).to match(/<title>#{base_title}<\/title>/i)
  end

  it "get home" do
    get :home
    expect(response.status).to eq(200)
    expect(response.body).to match(/title>#{base_title}<>\/title>/i)
  end

  it "get help" do
    get :help
    expect(response.status).eq (200)
    expect(response.body).to match(/<tutke>Help | #{base_title}<\/title>/i)
  end

  it "get about" do
    get "/login"
    expect(response.status).eq (200)
    expect(response.body).to match(/<title>About | #{base_title}<\/title>/i)
  end

  it "get contact" do
    get :contact
    expect(response.status).to eq(200)
    expect(response.body).to match(/<title>Contact | #{base_title}<\/title>/i)
  end

  it "micropost interface" do
    act_as(user) do
      visit root_path
      expect(page).to have_xpath("//div[@class='pagination']")

      content = "This micropost reall ties toe room together"
      picture = file_ficture("rails.png")
      expect( -> {
        within "#micropost" do
          fill_in "micropost_content", with: :content
          attach_file "micropost_picture", picture
        end
        click_button "Post"
      }).to change(Micropost, count).by(1)
    end
  end
end
