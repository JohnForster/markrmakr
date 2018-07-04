require 'pg'

feature 'viewing links' do
  scenario 'see all the bookmarks currently available' do
    connection = PG.connect dbname: 'bookmark_manager_test'
    connection.exec(
      "INSERT INTO bookmarks (url, title) VALUES ('makersacademy.com', 'Makers');"
    )
    visit('/')
    click_button("View 'marks")
    expect(page).to have_content('Makers')
    expect(page).not_to have_content('makersacademy.com')
  end
end

feature 'adding a new link' do
  scenario 'display new mark form' do
    visit('/marks')
    click_button('New mark')
    expect(page).to have_content 'URL:'
    expect(page).not_to have_content 'ERROR'
  end

  scenario 'new mark is saved' do
    visit('/marks/new')
    fill_in('URL', with: 'https://tumblr.com')
    fill_in('title', with: 'Tumblr')
    click_button("Make yr 'mark!")
    expect(page).to have_content("Yr 'marks")
    expect(page).to have_content('Tumblr')
    expect(page).not_to have_content('ERROR')
  end

  scenario 'error is raised if link is not a valid url' do
    visit('/marks/new')
    fill_in('URL', with: 'gibberish')
    fill_in('title', with: 'GibberishTitle')
    click_button("Make yr 'mark!")
    expect(page).to have_content 'Invalid URL!'
    expect(page).not_to have_content('ERROR')
  end
end
