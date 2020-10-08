require 'rails_helper'

RSpec.describe "Books", type: :system do
  let(:usr){ create(:user) }
  let!(:user2){ create(:user) }
  let!(:book){ create(:book, user: user) }
  let!(:book2){ create(:book, user: user2) }

  before do
    visit new_user_session_path
    fill_in "user[name]", with: user.name
    fill_in "user[password]", with: user.password
    click_button "Log in"
  end
  describe "test for sidebar" do
    context "check text" do
      it "has 'New Book'" do
        expect(page).to have_content "New Book"
      end
      it "has title form" do
        expect(page).to have_field "book[title]"
      end
      it "has opinion form" do
        expect(page).to have_field "book[body]"
      end
      it "has create button" do
        expect(page).to have_button "Create Book"
      end
      it "succeed to create book" do
        fill_in "book[title]", with: Faker::Lorem.characters(number: 5)
        fill_in "book[body]", with: Faker::Lorem.characters(number: 20)
        click_button "Create Book"
        expect(page).to have_content "successfully"
      end
      it "fail to create book" do
        click_button "Create Book"
        expect(page).to have_content "error"
        expect(current_path).to eq "/books"
      end
    end
  end

  describe "test for editting" do
    cibtext "go to own page" do
      it "can go" do
        visit edit_book_path(book)
        expect(current_path).to eq "/books/#{book.id}/edit"
      end
    end
    context "go to others page" do
      it "canNOT go" do
        visit edit_book_path(book2)
        expect(current_path).to eq "/books"
      end
    end
    context "check content" do
      before do
        visit edit_book_path(book)
      end
      it "has 'Editing Book'" do
        expect(page).to have_content "Editing Book"
      end
      it "has title form" do
        expect(page).to have_field "book[title]", with: book.title
      end
      it "has body form" do
        expect(page).to have_field "book[body]", with: book.body
      end
      it "has show link" do
        expect(page).to have_link "Show", href: book_path(book)
      end
      it "has back link" do
        expect(page).to have_link "Back", href: books_path
      end
    end
    context "check form" do
      it "succeed to edit" do
        visit edit_book_path(book)
        click_button "Update Book"
        expect(page).to have_content "successfully"
        expect(current_path).to eq "/books/#{book.id}"
      end
      it "fail to edit" do
        visit edit_book_path(book)
        fill_in "book[title]", with: ""
        click_button "Update Book"
        expect(page).to have_content "error"
        expect(current_path).to eq "/books/#{book.id}"
      end
    end
  end

  describe "test for index" do
    before do
      visit books_path
    end
    context "check content" do
      it "has 'Books'" do
        expect(page).to have_content "Books"
      end
      it "check image's link" do
        expect(page).to have_link "", href: user_path(book.user)
        expect(page).to have_link "", href: user_path(book2.user)
      end
      it "check title link" do
        expect(page).to have_link book.title, href: book_path(book)
        expect(page).to have_link book2.title, href: book_path(book2)
      end
      it "check opinions" do
        expect(page).to have_content book.body
        expect(page).to have_content book2.body
      end
    end
  end

  describe "test for show" do
    context "has shared information with other" do
      it "has 'Book detail'" do
        visit book_path(book)
        expect(page).to have_content "Book detail"
      end
      it "has right link from image and name" do
        visit book_path(book)
        expect(page).to have_link book.user.name, href: user_path(book.user)
      end
      it "has title" do
        visit book_path(book)
        expect(page).to have_content book.title
      end
      it "has body" do
        visit book_path(book)
        expect(page).to have_content book.body
      end
    end
    context "has own information" do
      it "has edit link" do
        visit book_path(book)
        expect(page).to have_link "Edit", href: edit_book_path(book)
      end
      it "has destroy link" do
        visit book_path(book)
        expect(page).to have_link "Destroy", href: book_path(book)
      end
    end
    context "NOT have information for other" do
      it "NOT have edit link" do
        visit book_path(book2)
        expect(page).to have_no_link "Edit", href: edit_book_path(book2)
      end
      it "NOT have desroy link" do
        visit book_path(book2)
        expect(page).to have_no_link "Destroy", href: book_path(book2)
      end
    end
  end
end