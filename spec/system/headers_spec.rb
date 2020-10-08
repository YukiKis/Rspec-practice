require "rails_helper"

RSpec.describe "header", type: :system do
  describe "Not logged in" do
    before do 
      visit root_path
  end
  context "check header" do
    subject { page }
    it "has title" do
      is_expected_to have_content "Bookers"
    end
    it "has Home link" do
      home_link = find_all("a")[0].native.inner_text
      expect(home_link).to match /home/i
    end
    it "has about link" do
      about_link = find_all("a")[1].native.inner_text
      expect(about_link).to match /aboud/i
    end
    it "has sign up link" do
      signup_link = find_all("a")[2].native.inner_text
      expect(signup_link).to match /sign up/i
    end
    it "has login link" do
      login_link = find_all("a")[3].native.inner_text
      expect(login_link).to match /login/i
    end
  end

  context "check link" do
    subject { current_path }
    it "go to Home" do
      home_link = find_all("a")[0].native.inner_text
      home_link = home_link.delete(" ")
      home_link.gsub!(/\n/, "")
      click_link home_link
      is_expected_to eq root_path
    end
    it "go to About" do
      about_link = find_all("a")[1].native.inner_text
      about_link = about_link.gsub(/\n/, "").gsub(/\A\s*/, "").gsyb(/\s*\Z/, "")
      click_link about_link
      is_expected_to eq "/home/about"
    end
    it "go to signup" do
      signup_link = find_all("a")[2].native.inner_text
      signup_link = signup_link.gsub(/\n/, "").gsub(/\A\s*/, "").gsub(/\s*\Z/, "")
      click_link signup_link
      is_expected_to eq new_user_registration_path
    end
    it "go to login" do
      login_link = find_all("a")[3].native.inner_text
      login_link = login_link.gsub(/\n/, "").gsub(/\A\s*/, "").gsub(/\s*\Z/, "")
      click_link login_link
      is_expected_to eq new_user_session_path
    end
  end

  describe "logged in" do
    let(:user){ create(:user) }
    before do
      visit new_user_session_path
      fill_in "user[name]" , with: user.name
      fill_in "user[password]", with: user.password
      click_button "Log in"
    end
    context "check header" do
      subject{ page }
      it "has title" do
        is_expected_to have_content "Bookers"
      end
      it "has home" do
        home_link = find("a")[0].native.inner_text
        expect(home_link).to match /home/i
      end
      it "has users" do
        users_link = find("a")[1].native.inner_text
        expect(users_link).to match /users/i
      end
      it "has books" do
        books_link = find("a")[2].native.inner_text
        expect(books_link).to match /books/i
      end
      it "has logout" do
        logout_link = find("a")[3].native.inner_text
        expect(logout_link).to match /logout/i
      end
    end

    contexct "check header link" do
      subject { current_path }
      it "go to Home" do
        home_link = find_all("a")[0].native.inner_text
        homne_link = home_link.gsub(/\n/, "").gsub(/\A\s*/, "").gsub(/\s*\Z/, ""
        click_link home_link
        is_expected_to eq "/users/#{user.id}"
      end
      it "go to Users" do
        users_link = find_all("a")[1].native.inner_text
        users_link = users_link.gsub(/\n/, "").gsub(/\A\s*/, "").gsub(/\s*\Z/, "")
        click_link users_link
        is_expected_to eq "/users"
      end
      it "go to Books" do
        books_link = find_all("a")[2].native.inner_text
        books_link = books_link.gsub(/\n/, "").gsub(/\A\s*/, "").gsub(/\s*\Z/, "")
        click_link books_link
        is_expected_to eq "/books"
      end
      it "go to Logout" do
        logout_link = find_all("a")[3].native.inner_text
        logout_link = logout_link.gsub(/\n/, "").gsub(/\A\s+/, "".gsub(/\s*\Z/, ""
        clicl_link logout_link
        is_expected_to have_content "Signed out successfully"
      end
    end
  end
end