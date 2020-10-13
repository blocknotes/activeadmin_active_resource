# frozen_string_literal: true

RSpec.describe 'Authors', type: :system do
  it 'fails to create an author', :vcr do
    visit '/admin/authors/new'

    fill_in('author[name]', with: 'Boh')
    fill_in('author[age]', with: '24')
    fill_in('author[email]', with: 'Some invalid e-mail address')
    find('#author_submit_action [type="submit"]').click

    error = find('#author_email_input .inline-errors').text
    expect(error).to include 'Invalid email'
  end

  it 'creates an author', :vcr do
    visit '/admin/authors/new'

    fill_in('author[name]', with: 'Some name')
    fill_in('author[age]', with: '30')
    fill_in('author[email]', with: 'some_email@example.com')
    find('#author_submit_action [type="submit"]').click

    expect(page).to have_http_status(:success)
    expect(page).to have_content('Author was successfully created.')
  end

  context 'with some authors' do
    it 'loads the authors list', :vcr do
      visit '/admin/authors'

      expect(page).to have_http_status(:success)
      expect(page).to have_css('#index_table_authors td.col-name', count: 4)
    end

    it 'loads an author', :vcr do
      visit '/admin/authors/1'

      expect(page).to have_http_status(:success)
      expect(page).to have_css('#attributes_table_author_1')
    end

    it 'fails to update an author', :vcr do
      visit '/admin/authors/1/edit'

      fill_in('author[name]', with: '')
      find('#author_submit_action [type="submit"]').click

      error = find('#author_name_input .inline-errors').text
      expect(error).to include "can't be blank"
      expect(error).to include "is too short"
    end

    it 'updates an author', :vcr do
      visit '/admin/authors/1/edit'

      fill_in('author[age]', with: '30')
      find('#author_submit_action [type="submit"]').click

      expect(page).to have_http_status(:success)
      expect(page).to have_content('Author was successfully updated.')
    end

    it 'destroys an author', :vcr do
      visit '/admin/authors'

      find_all('.delete_link.member_link').last.click

      expect(page).to have_http_status(:success)
      expect(page).to have_content('Author was successfully destroyed.')
    end
  end
end
