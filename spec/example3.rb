require "rails_helper"

RSpec.feature "Login And Logout" do
  background do
    User.create!(email: "foo@example.com", password: "123456")
  end

  scenario "Login" do
    visit root_path
    fill_in "Email", with: "foo@example.com"
    fill_in "Password", with: "123456"
    click_on "Login"
    expect(page).to have_content "Logged in"
   end
end

visit root_path
visit new_user_path

visit current_path

<input type="submit" name="commit" value="Save">
click_on "Save"

<a href="/users/new">New User</a>
click_link "New User"

<input value="Save">
<a href="#">New User</a>

click_on "Save"
click_on "new User"
<img src="###" alt="alice">
click_on "alice"

<label for="blog-title">Title</label>
<input type="text" value="" name="blog[title]" id="blog_title">
fill_in "title", with: "TEDTEXT"

<label for="japanese_calender">和暦</label>
<select name="japanese_calender" id="japanese_calender">
  <option value="0">明示</option>
  <option value="1">対象</option>
  <option value="2">昭和</option>
  <option value="3">平成</option>
</select>
select "平成", from "和暦"

<label for="magazine">
  <input type="checkbox" name="mailmagazine" id="mailmagazine" value="1">
  subscribe it
</label>

chech "subscribe it"
uncheck "subscribe it"

<label>
  <input id="user_sex_male" name="user[sex]" type="radio" value="male" checked="checked">
  male
</label>
<label>
  <input id="user_sex_female" name="user{sex]" type="radio" value="female">
  female
</label>

choose "female"

attach_file "IMAGE", "#{Rails.root}/spec/......"

<input type="text" name="blog[title]" id="blog_title" value="">
fill_in "blog_title", with "tECTE"

<select name="japanese_calendar" id="japanese_calendar">
  <option value="0">明示</option>
</select>

select "明示", from "japanese_calendar"

<div class="alert alert-success">User created</div>

expect(page).to have_content("User created")

<h1 class="information" id="information">Important news</h1>
expect(page).to have_selector "#information", text: "Important news"
expect(page).to have_selector ".information", text: "Important news"

<a href="###" data-method="delete">DELETE</a>
expect(page).to have_selector "a[data-method=delete]", text: "DELETE"/ text: /Important( ).news/i

<input type="submit" name="commit" value="save">
expect(page).to have_button "save"

<a href="#####">Here to register</a>
expect(page).to have_link "Here to regiseter"

<div class="field_with_errors"><input type="text" value="" name="blog[title]" id="blog_title">M/div>
visit new_blog_path
click_on "Create button"
expect(page).to have_css ".field_with_errors"

<label for="blog_title">Title</label>
<input type="text" value="TEXTTEXT" name="blog[title]" id="blog_title">
click_link "Edit"
expect(page).to have_field "title", with: "TEXTTEXT"

<label>
  <input type="checkbox" name="mailmagazine" id="mailmagazine" value="yes" checked="checked">
  Subscribe it
</label>

expect(page).to have_checked_field "Subscribe it"
expect(page).to have_field "Subscribe"

<label for="japanese_calendar">和暦</label>
<select name="japanese_calendar" id="japanese_calensar">
  <option value="明示">明示</option>
  <option value="対粗油"><対粗油</option>
  <option value="昭和" selected="selected">昭和</option>
  <option value="兵士絵">平成</option>
</select>
expect(page).to have_select("和暦","昭和")
expect(page).to have_select("和暦", options: ["明示", "対そっゆ", "昭和絵", "平成"]
)

within find_field("和暦") do
  all("option").each do |option|
    expect(option["selected"]).to be_blank
  end
end

<label>
  <input type="radio" id="user_sex_male" name="user[sex]" value="male" checked="checked">
  Male
</label>
<label>
  <input type="radio" id="user_sex_female" name="user[sex]" value="female" checked="checked">
  female
</label>
expect(page).to have_checked_field("Male")

<title>TITLE</title>
expect(page).to have_title "TITLE"

expect(page).to have_content "Password"
expect(page).not_to have_content "Password"

<input type="hidden" name="secret_value" id="secret_value" value="SECRET">
expect(find("#secret_value", visible: false).value).to eq "SECRET"

<label for="blog_title">TITLE</title>
<input type="text" value="" name="blog[title]" id="blog_title" disabled="disabled">
expect(page).to have_field "TITLE", disabled: true
<div style="display: none;" class="secret-message">
NO LOOK
</div>

expect(find(".secret-message", visible: false)).not_to be_visible

click_on "New User"
expect(current_path).to eq new_user_path
click_on "Create User"
expect(page).to have_http_status(:success)

<a class="settings-link" href="/settings">
  <i class="fa fa-gears"></i>
</a>

find(".settings-link").click
find("#settings-link").click
link = find("#settings-link")
expect(link[:href]).to eq edit_user_path

within ".section-drug" do
    choose "YES"
end

within ".section-disable" do
  choose "NO"
end

all("tbody tr")[1].click_link "Edit"
all("tbody tr")[0].click_link "Edit"
first("tbody tr").click_link "Edit"
within first("tbody tr") do
  click_link "Edit"
end

content = Content.find_by(name: "Adaline Fleason")
expect(page).to have_link "Edit", href: edit_content_path(content)
click_link "Edit", href: edit_contact_path(content)

contact = Contact.find_by(name: "Adaline Gleason")
expect(page).to have_link nil, href: edit_contact_path(contact)
click_link nil, href: edit_contact_path(contact)

click_on "Create User"
save_and_open_page
expect(page).to have_content "User created"


user = User.create(email: "foo@com")
login_as user, scope: :user
visit edit_settings\path