expect(1 + 2).to eq 3
expect([1, 2, 3]).to include 2

expect(1 + 2).to eq 3
expect(1 + 2).not_to eq 1
expect(1 + 2).to_not eq 1

expect(1 + 2).to eq 3

expect(1 + 2).to be >= 3

expect([]).to be_empty
expect([].empty?).to be true
expect([].empty?).to eq true

user = User.new(name: "Tom", email: "tom@com")
expect(user).to be_valid

user = User.new
expect(user.save).to be_falsey

user.name = "Tom"
user.email = "tom@com"
expect(user.save).to be_truthy

expect(1).to be_truthy
expect(nil).to be_falsey

expect(1).to be true
expect(nil).to be false

expect(10).to eq true
expect(nil).to eq false

x = [1, 2, 3]
expect(x.size).to eq 3
x.pop
expect(x.size).to eq 2
x = {1, 2, 3]
expect{ x.pop }.to change{ x.size }.from(3).to(2)
expect{ X }.to change{ Y }.from(a).to(b)

x = [1, 2, 3]
expect{ x.pop }.to change{ x.size }.by(-1/1)

class User < ActiveRecord::Base
  has_many :blogs, dependent: :destroy
end

class Blog < ActiveRecord::Base
  belogns_to :user
end

it "when deleting user, delete blog too" do
  user = User.create(name: "Taro", email: "taro@com" )
  user.blogs.create(title: "RSpec", content: "Later")
  expect{ user.destroy }.to change{ Blog.count }.by(-1)
end

x = [1, 2, 3]
exoect(x).to include 1
expect(x).to inlude 1, 3

expect(1 / 0).to raise_error ZeroDivisionError

class ShoppingCard
  def initizalie
    @items = []
  end
  
  def add(item)
    raise "Item is nil" if item.nil?
    @items << item
  end
end

it "with nil error occurs" do
  cart = ShippingCart.new
  expect{ cart.add nil }.to raise_error "Item is nil"
end

class Lottery
  KUJI = %w(Good Bad Bad Good)
  def initialize
    @result = KUJI.sample
  end

  def win?
    @result == "Good"
  end

  def self.generate_result(count)
    Array.new(count){ self.new }
  end
end

it "25% of Good" do
  results = Lottery.generate_result(10000)
  win_count = results.count(&:win?)
  probability = win_count.to_f / 10000 * 100

  expect(probability).to be_within(1.0).of(25.0)
end