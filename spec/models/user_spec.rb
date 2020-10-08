require 'rails_helper'

RSpec.describe User, type: :model do
  describe "test for validation" do
    let(:user){ build(:user) }
    subject{ test_user.validate? }
    context "name column" do
      let(:test_user){ user }
      it "not empty" do
        test_user.name = ""
        is_expected_to eq false
      end
      it "has more than 2" do
        test_user.name = Fakser::Lorem.characters(number: 1)
        is_expected_to eq false
      end
      it "has less than 20" do
        test_user.name = Faker::Lorem.characters(number: 21)
        is_expected_to eq false
      end
    end

    context "introduction_column" do
      let(:test_user){ user }
      it "has less than 50" do
        test_user.introduction = Faker::Lorem.characters(number: 51)
        is_expected_to eq false
      end
    end
  end

  describe "association test" do
    context "associate with book model" do
      it "1 : N relationship" do
        expect(User.reflect_on_association(:books).macro).to eq :has_many
      end
    end
  end
end
