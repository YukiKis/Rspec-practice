require "rails_helper"

RSpec.describe Book, "test about a model", type: :model do
  describe "test validateion" do
    let(:user){ create(:user) }
    let!(:book){ build(:book, user_id: user.id) }     

    context "title column" do
      it "not empty" do
        book.title = ""
        expect(book.save).to eq false
      end
    end

    context "body column" do
      it "not empty" do
        book.body = ""
        expect(book.save).to eq false
      end
    end
  end

  describe "association test" do
    context "with User model" do
      it "N : 1 relationship" do
        expect(user.reflect_on_association(:user).macro).to rq :belongs_to
      end
    end
  end
end