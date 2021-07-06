# Active Admin + Active Resource
[![gem version](https://badge.fury.io/rb/activeadmin_active_resource.svg)](https://badge.fury.io/rb/activeadmin_active_resource)
[![gem downloads](https://badgen.net/rubygems/dt/activeadmin_active_resource)](https://rubygems.org/gems/activeadmin_active_resource)
[![linters](https://github.com/blocknotes/activeadmin_active_resource/actions/workflows/linters.yml/badge.svg)](https://github.com/blocknotes/activeadmin_active_resource/actions/workflows/linters.yml)
[![specs](https://github.com/blocknotes/activeadmin_active_resource/actions/workflows/specs.yml/badge.svg)](https://github.com/blocknotes/activeadmin_active_resource/actions/workflows/specs.yml)

An Active Admin plugin to use a REST API data source in place of a local database using [Active Resource](https://github.com/rails/activeresource).

**NOTICE**: currently some Active Admin features don't work as expected:

- Filters are partially supported (see example)
- Some form fields must be configured explicitly (like the associations)
- Comments are not supported

Please :star: if you like it.

## Install

- Add to your project's Gemfile (with Active Admin installed): `gem 'activeadmin_active_resource'`
- Execute bundle
- Disable comments in Active Admin config initializer (`config.comments = false`)

## Examples

Please take a look at the examples folder:

- a Rails6 application with Active Admin and this component, see [here](examples/rails6-admin);
- a Rails6 API application used as data source, see [here](examples/rails6-api).

For another example check the [specs](spec).

Basic instructions:

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

If you create a new rails project don't use *--skip-active-record*.

## Do you like it? Star it!

If you use this component just star it. A developer is more motivated to improve a project when there is some interest. My other [Active Admin components](https://github.com/blocknotes?utf8=✓&tab=repositories&q=activeadmin&type=source).

Or consider offering me a coffee, it's a small thing but it is greatly appreciated: [about me](https://www.blocknot.es/about-me).

## Contributors

- [Mattia Roccoberton](http://blocknot.es): author

## License

The gem is available as open-source under the terms of the [MIT](LICENSE.txt).
