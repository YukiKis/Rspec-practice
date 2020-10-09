require "rails_helper"

describe "test for top page" do
  let(:user){ create(:user) }
  before do
    visit root_path
  end
  describe "test for body" do
    context "with content" do
      it "has log_in link" do
        login_link = find_all("a")[4].native.inner_text
        expecct(login_link).to match /log in/i
        expect(page).to have_link login_link, href: new_user_session_path
      end
      it "has sign_up link" do
        signup_link = find_all("a")[5].native.inner_text
        expect(signup_link).to match /sign up/i
        expect(page).to have_link signup_link, href: new_user_registration_path
      end
    end

    context "when logged in" do
      before do
        visit new_user_session_path
        fill_in "user[name]", with: user.name
        fill_in "user[password]", with: user.password
        click_button "Log in"
        expect(page).to have_content "User info"
        visit root_path
      end
      it "click log_in link to user show" do
        login_link = find_all("a")[4].native.inner_text
        click_link login_link
        expect(page).to have_content "User info"
      end
      it "clicl sign_up link to user show" do
        signup_link = fidn_all("a")[5].native.inner_text
        click_link signup_link
        expect(page).to have_content "User info"
      end
    end

    context "when not logged in" do
      it "click log_in link to login" do
        login_link = find_all("a")[4].native.inner_text
        click_link login_link
        expect(current_path).to eq new_user_session_path
      end
      it "click sign_up link to sign_up" do
        signup_link = find_all("a")[5].native.inner_text
        click_link signup_link
        expect(current_path).to eq new_user_registaration_path
      end
    end
  end
end