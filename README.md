# ActiveAdmin + Active Resource [![Gem Version](https://badge.fury.io/rb/activeadmin_active_resource.svg)](https://badge.fury.io/rb/activeadmin_active_resource)

An ActiveAdmin plugin to use a REST API in place of a local database as data source using [Active Resource](https://github.com/rails/activeresource).

WARNING: this component is a Beta version, some Active Admin functionalities don't work as expected:
- Filters: partially supported (see example)
- Edit: fields must be configured explicitly
- Comments: not supported

## Install
- Add to your Gemfile: `gem 'activeadmin_active_resource'`
- Execute bundle
- Disable comments in active_admin config initializer

## Example
- Post model:
```rb
class Post < ActiveResource::Base
  self.site = 'http://localhost:3000'  # API url: another Rails project, a REST API, etc.

  self.schema = {  # Fields must be declared explicitly
    id: :integer,
    title: :string,
    description: :text,
    author_id: :integer,
    category: :string,
    dt: :datetime,
    position: :float,
    published: :boolean,
    created_at: :datetime,
    updated_at: :datetime,
  }
end
```
- Post admin config:
```rb
ActiveAdmin.register Post do
  filter :title_cont  # Ransack postfixes required (_eq, _cont, etc.)

  controller do
    def permitted_params
      params.permit!  # Permit all just for testing
    end
  end

  form do |f|
    f.inputs do
      f.input :id, as: :hidden unless f.object.new_record?  # Required
      f.input :title
      # ... other fields
    end
    f.actions
  end
end
```
- Ransack options [here](https://github.com/activerecord-hackery/ransack#search-matchers)
- Rails API index example with Ransack and Kaminari:
```rb
  after_action :set_pagination, only: [:index]

  def index
    per_page = params[:per_page].to_i
    per_page = 15 if per_page < 1
    @posts = Post.ransack( params[:q] ).result.order( params[:order] ).page( params[:page].to_i ).per( per_page )
  end

  def set_pagination
    headers['Pagination-Limit'] = @posts.limit_value.to_s
    headers['Pagination-Offset'] = @posts.offset_value.to_s
    headers['Pagination-TotalCount'] = @posts.total_count.to_s
  end
```

## Notes
If you create a new rails project don't use *--skip-active-record*

## Do you like it? Star it!
If you use this component just star it. A developer is more motivated to improve a project when there is some interest.

Take a look at [other ActiveAdmin components](https://github.com/blocknotes?utf8=✓&tab=repositories&q=activeadmin&type=source) that I made if you are curious.

## Contributors
[Mattia Roccoberton](http://blocknot.es): author

## License
[MIT](LICENSE.txt)
