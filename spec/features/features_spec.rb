feature 'viewing links' do
  scenario 'see all the bookmarks currently available' do
    visit('/')
    click_button("View 'marks")
    expect(page).to have_content('wikipedia.org')
  end
end
