RSpec.describe "四則演算" do
  describe "足し算" do
    it "1 + 1 = 2" do
      expect(1 + 1).to eq 2
    end
  end
  
  describe "引き算" do
    it "10 - 1 = 9" do
      expect(10 - 1).to eq 9
    end
  end
end

class User 
  def initialze(name, age)
    @name = name
    @age = age
  end

  def greet
    if @age <= 12
      "ぼくは#{@age}さいだよ"
    else
      "I am #{@age}."
    end
  end

  def child?
    @age <= 12
  end
end

Rspec.describe User do
  describe "greet" do
    context "greet with diff age" do
      it "under 12, using Hiragana" do
        user = User.new(name: "Taro", age: 10)
        expect(user.greet).to eq "ぼくは10よ"
      end

      it "over 13, using English" do
        user= User.new(name: "Taro", age: 15)
        expect(user.greet).to eq "I am 15."
      end
    end
  end
end

RSpec.describe User do
  describe "greet" do
    before do 
      @params = { name: "Taro" }
    end

    context "Under 12" do
      it "Using Hiragana" do
        user = User.new(@params.merge(age: 12))
        expect(user.greet).to eq "ぼくはたろうだよ"
      end
    end

    context "Over 13" do
      it "Using English" do
        user = User.new(@params.merge(age: 15))
        expect(user.greet).to eq "I am Taro"
      end
    end
  end
end

RSpec.describe User do
  describe "Greet" do
    let(:params) { {name: "Taro" } }
    context "Under 12" do
      before do 
        params.merge!(age: 12)
      end
      it "Hiragana" do
        user = User.new(params)
        expect(user.greet).to eq "ぼくはたろうだよ"
      end
    end

    context "Over 13" do
      before do
        params.merge!(age: 13)
      end
      it "Using English" do
        user = User.new(params)
        expect(user.greet).eq "I am Taro"
      end
    end
  end
end

RSpec.describe User do
  describe "greet" do
    let(:user){ User.new(params) }
    let(:params){ { name: "Taro", age: age } }
    context "under 12" do
      let(:age) { 12 }
      it "Using Hiragana" do
        expect(user.greet).to eq "ぼくはたろうだよ"
      end
    end
    context "Over 13" do
      let(:age) { 13 }
      it "Using English" do
        expect(user.greet).to eq "I am Taro"
      end
    end
  end
end

RSpec.describe User do
  describe "greet" do
    let(:user) { User.new(params) }
    let(:params) { { name: "Taro", age: age } }
    subject{ user.greet }
    context "under 12" do
      let(:age) { 12 }
      it "Hiragana" do
        is_expected_to eq "ぼくはたろうだよ"
      end
    end

    context "Over 13" do
      let(:age) { 13 }
      it "Using English" do
        is_expected_to eq "I am Taro"
      end
    end
  end
end

RSPec.descrite User do
  describe "greet" do
    let(:user){
      user.new{ name: "Taro", age: age }
    }
    subject{ user.greet }
    
    context "Under 12" do
      let(:age){ 12 }
      it { is expected_to eq "ぼくはたろうだよ"}
    end

    context "Over 13" do
      let(:age){ 13 }
      it { is expected_to eq "I am Taro" }
    end
  end
end


# under 3 are same 
# it "1 + 1 = 2" do
# end

# specify "1 + 1 = 2" do
# end

# example "1 + 1 = 2" do
# end

RSpec.describe User do
  describe "greet" do
    let(:user){ User.new(name: "Taro", age: age) }
    subject{ user.greet }

    shared_examples "kid greeting" do
      it { is_expected_to eq "ぼくはたろうだよ" }
    end

    context "when 0 years old" do
      let(:age){ 0 }
      it_behaves_like "kid greeting"
    end

    context "when 12 years old" do
      let(:age){ 12 }
      it_behaves_like "kid greeting"
    end

    shared_examples "adult greeting" do
      it { is_expected_to eq "I am Taro"}
    end

    context "when 13 years old" do
      let(:age){ 13 }
      it_behaves_like "adult greeting"
    end

    context "when 100 years old" do
      let(:age){ 100 }
      it_behaves_like "adult greeting"
    end
  end
end

RSpec.describe User do
  describe "greet" do
    let(:user){ User.new(name: "Taro", age: age ) }
    subject{ user.greet }
    shared_context "under 12" do
      let(:age){ 12 }
    end
    shared_context "over 13" do
      let(:age){ 13 }
    end

    context "under 12" do
      include_context "under 12"
      it { is_expected_to eq "ぼくはたろう" }
    end
    context "Over 13" do
      include_context "over 13"
      it { is_expected_to eq "I am Taro" }
    end
  end

  describe "child?" do
    let(:user){ User.new(name: "Taro", age: age) }
    subject{ user.child? }
    context "under 12" do
      include_context "under 12"
      it { is_expected_to eq true }
    end
    context "over 13" do
      include_context "over 13"
      it { is_expected_to eq false }
    end
  end
end

RSpec.describe Blog do
  let(:blog){ Blog.create(title: "RSpec", content: "Later") }
  it "get blog" do
    expect(Blog.first).to eq blog
  end
end

RSpec.describe Blog do
  let(:blog){ Blog.create(title: "RSpec", content: "Later") }
  before do
    blog
  end
  it "get blog" do
    expect(Blog.first).eq blog
  end
end

RSpec.describe Blog do
  let!(:blog){ Blog.create(title: "RSpec", content: "Later") }
  it "get blog" do
    expect(Blog.first).eq blog
  end
end

RSpec.describe "Pretty difficult class" do
  it "difficult class" do
    expect(1 + 2).eq 3
    # pending "Later check" 保留
    # skip "FINISH right now" これ以降実行されない
    # xit, xdescribe xcontext まとめてski@
    expect(foo).to eq bar
  end
end