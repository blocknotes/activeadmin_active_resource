# frozen_string_literal: true

RSpec.describe 'Posts', type: :system do
  it 'fails to create a post', :vcr do
    visit '/admin/posts/new'

    fill_in('post[title]', with: '')
    find('#post_submit_action [type="submit"]').click

    error = find('#post_title_input .inline-errors').text
    expect(error).to include "can't be blank"
    expect(error).to include "is too short"
  end

  context 'with some authors' do
    it 'creates a post', :vcr do
      visit '/admin/posts/new'

      fill_in('post[title]', with: 'Some title')
      select('Mat', from: 'post[author_id]')
      find('#post_submit_action [type="submit"]').click

      expect(page).to have_http_status(:success)
      expect(page).to have_content('Post was successfully created.')
    end
  end

  context 'with some posts' do
    it 'loads the posts list', :vcr do
      visit '/admin/posts'

      expect(page).to have_http_status(:success)
      expect(page).to have_css('#index_table_posts td.col-title', count: 3)
    end

    it 'loads a post', :vcr do
      visit '/admin/posts/1'

      expect(page).to have_http_status(:success)
      expect(page).to have_css('#attributes_table_post_1')
    end

    it 'fails to update a post', :vcr do
      visit '/admin/posts/1/edit'

      fill_in('post[title]', with: '')
      find('#post_submit_action [type="submit"]').click

      error = find('#post_title_input .inline-errors').text
      expect(error).to include "can't be blank"
      expect(error).to include "is too short"
    end

    it 'updates a post', :vcr do
      visit '/admin/posts/1/edit'

      fill_in('post[description]', with: 'Some desc')
      find('#post_submit_action [type="submit"]').click

      expect(page).to have_http_status(:success)
      expect(page).to have_content('Post was successfully updated.')
    end

    it 'destroys a post', :vcr do
      visit '/admin/posts'

      find_all('.delete_link.member_link').last.click

      expect(page).to have_http_status(:success)
      expect(page).to have_content('Post was successfully destroyed.')
    end
  end
end
