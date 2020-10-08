require 'rails_helper'

RSpec.describe "Bootstraps", type: :system do
  let(:user){ create(:user) }
  let!(:book){ create(:book, user: user) }
  describe "test for Grid System" do
    before do
      visit new_user_session_path
      fill_in "user[name]", with: user.name
      fill_in "user[password]", with: user.password
      click_button "Log in"
    end
    context "About user" do
      it "index" do
        visit users_path
        expect(page).to have_selector ".container .row .col-xs-3"
        expect(page).to have_selector ".container .row .col-xs-9"
      end
      it "show" do
        visit user_path(user)
        expect(page).to have_selecotr ".container .row .col-xs-3"
        expect(page).to have_selector ".container .row .col-xs-9"
      end
    end
    context "About book" do
      it "index" do
        visit books_path
        expect(page).to have_selector ".container .row .col-xs-3"
        expect(page).to have_selector ".container .row .col-xs-9"
      end
      it "show" do
        visit book_path(book)
        expect(page).to have_selector ".container .row .col-xs-3"
        expect(page).ro have_selector ".container .row .col-xs-9"
      end
    end
  end
end
