require 'rails_helper'

describe "Beers page" do
  it "allows user to navigate to page New Beer" do
    visit beers_path
    click_link "New Beer"

    expect(page).to have_content "New Beer"
  end

  it "allows to make a new beer with valid name" do
    brewery=FactoryGirl.create(:brewery)
    visit new_beer_path
    fill_in('Name', with:'Olut')
    click_button('Create Beer')
    expect(brewery.beers.count).to eq(1)
    expect(Beer.count).to eq(1)
  end

  it "doesn't allow to make a new beer with invalid name" do
    brewery=FactoryGirl.create(:brewery)
    visit new_beer_path
    click_button('Create Beer')
    expect(brewery.beers.count).to eq(0)
    expect(Beer.count).to eq(0)
    expect(page).to have_content "Name can't be blank"
  end
end