# frozen_string_literal: true

RSpec.describe 'Tags', type: :system do
  context 'with some tags' do
    it 'loads the tags list', :vcr do
      visit '/admin/tags'

      expect(page).to have_http_status(:success)
      expect(page).to have_css('#index_table_tags td.col-name', count: 5)
    end

    it 'filters the tags', :vcr do
      visit '/admin/tags'

      fill_in('q[name_cont]', with: 'Some tag')
      find('[type="submit"][value="Filter"]').click
      expect(page).to have_css('#index_table_tags td.col-name', count: 1)
      name = find('#index_table_tags td.col-name')
      expect(name.text).to eq 'Some tag'
    end

    it 'loads a tag', :vcr do
      visit '/admin/tags/1'

      expect(page).to have_http_status(:success)
      expect(page).to have_css('#attributes_table_tag_1')
    end
  end
end
