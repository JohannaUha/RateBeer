require 'rails_helper'

include Helpers

describe "Rating" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
  let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery }
  let!(:user) { FactoryGirl.create :user, username:"Pekka" }

  before :each do
    visit signin_path
    fill_in('username', with:'Pekka')
    fill_in('password', with:'Foobar1')
    click_button('Log in')
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end

  it "lists the ratings and their total number" do
    ratings = FactoryGirl.create_list :rating, 2
    visit ratings_path
    expect(page).to have_content "Number of ratings: #{ratings.count}"
    ratings.each do |rating|
      expect(page).to have_content rating.to_s
    end
  end

  it "lists all user's ratings in user page" do
    user = FactoryGirl.create :user
    FactoryGirl.create :rating, user:user
    FactoryGirl.create :rating, user:user
    visit user_path(user)
    User.first.ratings.each do |rating|
      expect(page).to have_content rating.to_s
    end
  end


  it "allows deleting ratings" do
    sign_in(username: "Pekka", password: "Foobar1")
    brewery = Brewery.create name: "Brewery", year: 2000
    user = User.first
    beer = Beer.create name: "Test", style: "Lager", brewery_id: brewery.id
    Rating.create score: 20, beer_id: beer.id, user_id: user.id
    visit user_path(user)
    expect {
      click_on('delete')
    }.to change { Rating.count }.by(-1)
  end

end