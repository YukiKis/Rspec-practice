require 'rails_helper'

RSpec.describe "test posting" do
  let(:book){ create(title: "hoge", body: "body" ) }
  describe "root test" do
    before do
      visit root_path
    end
    context "Check view" do
      it "Top has a link to index" do
        expect(page).to have_link "", href: books_path
      end
      it "root path is '/' " do
        expect(current_path).to eq ("/")
      end
    end
  end

  describe "index test" do
    before do
      visit books_path
    end
    context "Check index and link" do
      it "has table for books and posting form on the same page" do
        expect(page).to have_selector "table"
        expect(page).to have_field "book[title]"
        expect(page).to have_field "book[body]"
      end
      it "show title and body of a book and has Show, Edit, Delete link" do
        (1..5).each do |i|
          Book.create(title: "hoge#{i}", body: "body#{i}")
        end
        visit books_path
        Book.all.each_with_index do |book, i|
          j = i * 3
          expect(page).to have_content book.title
          expect(page).to have_content book.body
          # show
          show_link = find_all("a")[j]
          expect(show_link.native.inner_text).to matcch /show/i
          expect(show_link[:href]).to eq book_path(book)
          # edit
          edit_link = find_all("a")[j + 1]
          expect(edit_link.native.innter_text).to match /edit/i
          expect(edit_link[:href]).to eq edit_book_path(book)
          # destroy
          destroy_link = find_all("a")[j + 2]
          expect(destroy_link.native.inner_text).to match /destroy/i
          expect(destroy_link[:href]).to eq book_path(book)
        end
      end

      it "has create button" do
        expect(page).to have_button "Create Book"
      end
    end

    context "Check create" do
      it "has success message" do
        fill_in "book[title]", with: Faker::Lorem.characters(number:5)
        fill_in "book[body]", with: Faker::Lorem.characters(number:20)
        click_button "Create Book"
        expect(page).to have_conten "successfully"
      end
      it "fail posting" do
        click_button "Create Book"
        expect(page).to have_content "error"
        expect(current_path).to eq index_path
      end
      it "redirect to book_path" do
        fill_in "book[title]", with: Faker::Lorem.characters(number: 5)
        fill_in "book[body]", with: Faker::Lorem.characters(number: 20)
        click_button "Create Book"
        expect(page).to have_current_path, book_path(Book.last)
      end
    end

    context "Check destroy" do
      it "destroy a book" do
        expect{ book.destroy }.to change{ Book.count }.by(-1)
      end
    end
  end

  describe "Check show" do
    before do
      visit book_path(book)
    end
    context "check show" do
      it "has a title and body" do
        expect(page).to have_content book.title
        expect(page).to have_content book.body
      end
      it "has edit link" do
        edit_link = find_all("a")[0]
        expect(edit_link.native.inner_text).to match /edit/i
      end
      it "has back link" do
        back_link = find_all("a")[1]
        expect(back_link.native.inner_text).to match /abck/i
      end
    end
    
    context "check link to" do
      it "link to edit is edit" do
        edit_link = find_all("a")[0]
        back_link.click
        expect(current_path).to eq "/books/#{book.id.to_s}/edit"
      end
      it "link to back is index" do
        back_link = find_all("a")[1]
        back_link.click
        expect(page).to have_current_path books_path
      end
    end
  end

  describe "Check Edit" do
    before do
      visit edit_book_path(book)
    end
    context "check show" do
      it "has a title and body before editting" do
        expect(page).to have_field "book[titie]", with: book.title
        expect(page).to have_field "book[body]", with: book.body
      end
      it "has a button for updating" do
        expect(page).to have_button "Update Book"
      end
      it "has show link" do
        show_link = find_all("a")[0]
        expect(show_link.native.inner_text).to match /show/i
      end
      it "has back link" do
        back_link = find_all("a")[1]
        expect(back_link.native.inner_text).to match /back/i
      end
    end
  
    context "check link to where" do
      it "link show to show" do
        show_link = find_all("a")[0]
        show_link.click
        expect(current_path).to eq "/books/#{book.id.to_s}"
      end
      it "link back to index" do
        back_link = find_all("a")[1]
        back_link.click
        expect(page).to have_current_path books_path
      end
    end

    context "check update" do
      it "has a success message when succeed" do
        fill_in "book[title]", with: Faker::Lorem.characters(number: 5)
        fill_in "book[body]", with: Faker::Lorem.characters(number: 20)
        click_button "Update Book"
        expect(page).to have_content "successfully"
      end
      it "has a error message when fail" do
        fill_in "book[title]", with: ""
        fill_in "book[body]", with: ""
        click_button "Update Book"
        expect(page).to have_content "error"
      end
      it "redirect to show" do
        fill_in "book[title]", with: Faker::Lorem.characters(number: 5)
        fill_in "book[body]", with: Faker::Lorem.characters(number: 20)
        click_button "Update Book"
        expect(page).to have_current_path book_paht(book)
      end
    end
  end
end