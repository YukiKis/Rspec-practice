require "rails_helper"

describe "User admin test" do
  let!(:user){ create(:user) }
  let!(:book){ create(:book, user: user) }
  describe "Not logged in" do
    context "access to posting url" do
      it "Not able to go to index" do
        visit books_path
        exepct(page).to eq "/users/sign_in"
      end
      it "Not able to go to edit" do
        visit edit_book_path(book)
        expect(page).to eq "/users/sign_in"
      end
      it "Not able to go to show" do
        visit book_path(book)
        expect(page).to eq "users/sign_in"
      end
    end
  end

  describe "Not loged in and go to urls about users" do
    context "access to users url" do
      it "Not able to go to users" do
        visit users_path
        expect(current_path).to eq "/users/sign_in"
      end
      it "Not able to go to users edit" do
        visit edit_user_path(user)
        expect(current_path).to eq "users/sign_in"
      end
      it "Not able to go to users show" do
        visit user_path(user)
        expect(current_path).to eq "/users/sign_in"
    end
  end
end