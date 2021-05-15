# frozen_string_literal: true

require 'json'
require 'roda'
require 'sequel'

require_relative 'conf'
Dir[File.expand_path("./models/*.rb", __dir__)].sort.each { |f| require f }

# Main app class
class App < Roda
  plugin :all_verbs
  plugin :halt
  plugin :json
  plugin :json_parser
  plugin :type_routing

  route do |r|
    # r.root do; end

    # --- authors ---
    r.is 'authors' do
      r.get do
        action_index(Models::Author, r.params)
      end

      r.post do
        author = Models::Author.new
        action_save(author, r.params) ? { author: author.values } : { errors: author.errors }
      end
    end

    r.is 'authors', Integer do |id|
      @author = Models::Author[id]
      r.halt(404) unless @author

      r.get do
        { author: @author.values }
      end

      r.put do
        action_save(@author, r.params) ? { tag: @author.values } : { errors: @author.errors }
      end

      r.delete do
        @author.destroy
        r.halt 204
      end
    end

    # --- posts ---
    r.is 'posts' do
      r.get do
        action_index(Models::Post, r.params)
      end

      r.post do
        post = Models::Post.new
        action_save(post, r.params) ? { post: post.values } : { errors: post.errors }
      end
    end

    r.is 'posts', Integer do |id|
      @post = Models::Post[id]
      r.halt(404) unless @post

      r.get do
        { post: @post.values }
      end

      r.put do
        action_save(@post, r.params) ? { tag: @post.values } : { errors: @post.errors }
      end

      r.delete do
        @post.destroy
        r.halt 204
      end
    end

    # --- tags ---
    r.is 'tags' do
      r.get do
        action_index(Models::Tag, r.params)
      end

      r.post do
        tag = Models::Tag.new
        action_save(tag, r.params) ? { tag: tag.values } : { errors: tag.errors }
      end
    end

    r.is 'tags', Integer do |id|
      @tag = Models::Tag[id]
      r.halt(404) unless @tag

      r.get do
        { tag: @tag.values }
      end

      r.put do
        action_save(@tag, r.params) ? { tag: @tag.values } : { errors: @tag.errors }
      end

      r.delete do
        @tag.destroy
        r.halt 204
      end
    end
  end

  # ----------------------------------------------------------------------------

  def action_index(model, params)
    ds = model.raw_dataset.paginate((params['page'] || 1).to_i, (params['per_page'] || 10).to_i)
    response.headers['Pagination-TotalCount'] = ds.pagination_record_count.to_s
    ds.to_a
  end

  def action_save(item, params)
    item.update(adjust_params(params)) # TODO: permit valid params only
    true
  rescue Sequel::ValidationFailed
    response.status = 422
    false
  end

  def adjust_params(params)
    item_params = params.dup
    item_params.delete_if { |k, _| k =~ /\Aid|\w+\(\d+i\)\Z/ } # TODO: handle date times fields
  end
end
