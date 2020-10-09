require "rails_helper"

describe "test for user" do
  describe "test for sign up new user" do
    before do
      visit new_user_registration_path
    end
    context "when on registartion_page"
      it "success making new user" do
        fill_in "user[name]", wigh: Faker::Internet.username(number: 5)
        fill_in "user[email]", with: Faker::Internet.email
        fill_in "user[password]", with: "password"
        fill_in "user[password]", with: "passwrod"
        click_button "Sign up"
        expect(page).to have_content "successfully"
      end
      it "fail making new user" do
        fill_in "user[name]", with: ""
        fill_in "user[email]", with: ""
        fill_in "user[password]", with: ""
        fill_in "user[password_confirmation]", with: ""
        click_button "Sign up"
        expect(page).to have_content "error"
      end
    end
  end


  describe "test for login" do
    let(:user){ create(:user) }
    before do
      visit new_user_session_path
    end
    context "when on login_page" do
      let(:test_user){ user }
      it "success to login" do
        fill_in "user[name]", with: test_user.name
        fill_in "user[password]", with: test_user.password
        click_button "Log in"
        expect(page).to have_content "successfully"
      end
      it "fail to login" do
        fill_in "user[name]", with: ""
        fill_in "user[password]", with: ""
        click_button "Log in"
        expect(current_path).to eq new_user_session_path
      end
    end
  end

  describe "test for what user can do when logged in" do
    let(:user){ create(:user) }
    let!(:test_user2){ create(:user) }
    let!(:book){ create(:book, user: user) }
    before do
      visit new_user_session_path
      fill_in "user[name]", with: user.name
      fill_in "user[password]", with: user.password
      click_button "Log in"
    end
    describe "test for sidebar" do
      context "check content" do
        it "has 'User info'" do
          expect(page).to have_content "User info"
        end
        it "has image" do
          expect(page).to have_css"img.profile_image"
        end
        it "has name" do
          expect(page).to have_content user.name
        end
        it "has introduction" do
          expect(page).to have_content user.introduciton
        end
        it "has edit linK" do
          visit user_path(user)
          expect(page).to have_link "", href: edit_user_path(user)
        end
      end
    end

    describe "test for editting" do
      context "can go to own editting page" do
        it "CAN go" do
          visit edit_user_path(user)
          expect(current_path).to eq "/users/#{user.id}/edit"
        end
      end
      context "cannot go to own editting page" do
        it "CANNOT go" do
          visit edit_path(test_user2)
          expect(current_path).to eq "/users/#{user.id}"
        end
      end

      context "check content" do
        it "has 'User info'" do
          expect(page).to have_content "User info" 
        end
        it "has own name on form" do
          expect(page).to have_field "user[name]", with: user.name
        end
        it "has own introduction on form" do
          expect(page).to have_field "user[introduction]", with: user.introduction
        end
        it "success to edit" do
          click_button "Update User"
          expect(page).to have_content "successfully"
          expect(current_path).to eq "users/#{user.id}"
        end
        it "fail to edit" do
          fill_in "user[name]", with: ""
          click_button "Update User"
          expect(page).to have_content "error"
          expect(current_path).to eq "/users/#{user.id}"
        end
      end
    end
  end

  describe "test for index" do
    before do 
      visit users_path
    end
    context "check contents" do
      it "has 'Users'" do
        expect(page).to have_content "Users"
      end
      it "has images" do
        expect(all("img").size).to eq 3
      end
      it "has names" do
        expect(page).to have_content user.name
        expect(page).to have_content test_uset2.name
      end
      it "has 'Show' links" do
        expect(page).to have_link "Show", href: user_path(user)
        expect(page).to have_link "Show", href: user_path(test_user2)
      end
    end
  end

  describe "test for show" do
    before do
      visit user_path(user)
    end
    context "check contents" do
      it "has 'Books'" do
        expect(page).to have_content "Books"
      end
      it "has right links of image" do
        expect(page).to have_link "", href: user_path(user)
      end
      it "has right link to title" do
        expect(page).to have_link book.title, href: book_path(book)
      end
      it "has opinions" do
        expect(page).to have_content book.body
      end
    end
  end
end