require 'pg'

feature 'viewing links' do
  scenario 'see all the bookmarks currently available' do
    connection = PG.connect dbname: 'bookmark_manager_test'
    connection.exec(
      "INSERT INTO bookmarks (url, title)
       VALUES ('makersacademy.com', 'Makers');"
    )
    visit('/')
    click_button("View marks")
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
    click_button("Make yr mark!")
    expect(page).to have_content("Yr marks")
    expect(page).to have_content('Tumblr')
    expect(page).not_to have_content('ERROR')
  end

  scenario 'error is raised if link is not a valid url' do
    visit('/marks/new')
    fill_in('URL', with: 'gibberish')
    fill_in('title', with: 'GibberishTitle')
    click_button("Make yr mark!")
    expect(page).to have_content 'Invalid URL!'
    expect(page).not_to have_content('ERROR')
  end
end

feature 'clicking a link' do
  scenario 'should take you to the contained link' do
    connection = PG.connect dbname: 'bookmark_manager_test'
    connection.exec(
      "INSERT INTO bookmarks (url, title)
       VALUES ('http://makersacademy.com', 'Makers');"
    )
    visit('/')
    click_button("View marks")
    expect(page).to have_link('Makers', href: 'http://makersacademy.com')
  end
end

feature 'deleting a link' do
  scenario 'should remove the link from the database' do
    visit('/marks/new')
    fill_in('URL', with: 'https://bbc.co.uk')
    fill_in('title', with: 'BBC')
    click_button("Make yr mark!")
    click_button(id: 'BBC', value: 'Edit')
    click_button('Delete this mark')
    expect(page).to have_content 'Yr marks'
    expect(page).not_to have_content 'BBC'
  end
end

feature 'editing a link' do
  scenario 'should change the title and url of a link' do
    visit('/marks/new')
    fill_in('URL', with: 'https://gooogle.co.uk')
    fill_in('title', with: 'Goggle')
    click_button('Make yr mark!')
    click_button(id: 'Goggle', value: 'Edit')
    fill_in('URL', with: 'https://google.co.uk')
    fill_in('title', with: 'Google')
    click_button('Change mark')
    expect(page).to have_content('Google')
    expect(page).not_to have_content('Goggle')
  end

  scenario 'error is raised if link is not a valid url' do
    connection = PG.connect dbname: 'bookmark_manager_test'
    connection.exec(
      "INSERT INTO bookmarks (url, title)
       VALUES ('http://makersacademy.com', 'Makers');"
    )
    visit('/')
    click_button("View marks")
    click_button(id: 'Makers', value: 'Edit')
    fill_in('URL', with: 'gibberish')
    fill_in('title', with: 'GibberishTitle')
    click_button('Change mark')
    expect(page).to have_content 'Invalid URL!'
    expect(page).not_to have_content('ERROR')
  end
end
