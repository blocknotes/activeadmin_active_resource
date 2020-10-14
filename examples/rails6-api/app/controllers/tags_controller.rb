# frozen_string_literal: true

class TagsController < ApplicationController
  after_action :set_pagination, only: [:index]

  def index
    # filters using Ransack, pagination using Kaminari
    per_page = params[:per_page].to_i
    per_page = 15 if per_page < 1
    @tags = Tag.ransack(params[:q]).result.order(params[:order]).page(params[:page].to_i).per(per_page)

    render json: @tags
  end

  def show
    @tag = Tag.find(params[:id])

    render json: @tag
  end

  private

  def set_pagination
    headers['Pagination-Limit'] = @tags.limit_value.to_s
    headers['Pagination-Offset'] = @tags.offset_value.to_s
    headers['Pagination-TotalCount'] = @tags.total_count.to_s
  end
end
