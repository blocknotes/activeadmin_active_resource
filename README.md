# ActiveAdmin Active Resource [![Gem Version](https://badge.fury.io/rb/activeadmin_active_resource.svg)](https://badge.fury.io/rb/activeadmin_active_resource)

An Active Admin plugin to use Active Resource.

Data is fetched from an external API.

WARNING: this component is a Beta version, some Active Admin functionalities don't work as expected:

- Batch Action: not supported
- Filters: partially supported (see example)
- Edit: fields must be configured explicitly
- Comments: not supported

## Install

- Add to your Gemfile:
`gem 'activeadmin_active_resource'`
- Execute bundle
- Disable comments in active_admin config initializer

## Example

- Post model:

```rb
class Post < ActiveResource::Base
  self.site = 'http://localhost:3000'

  self.schema = {
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
  config.batch_actions = false

  filter :title_cont  # Ransack postfixes required (_eq, _cont, etc.)

  controller do
    def permitted_params
      params.permit!  # Just to make things easier :)
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

## Notes

If you create a new rails project don't use *--skip-active-record*

## Do you like it? Star it!

If you use this component just star it. A developer is more motivated to improve a project when there is some interest.

Take a look at [other ActiveAdmin components](https://github.com/blocknotes?utf8=✓&tab=repositories&q=activeadmin&type=source) that I made if you are curious.

## Contributors

- [Mattia Roccoberton](http://blocknot.es) - creator, maintainer

## License

[MIT](LICENSE.txt)
