# frozen_string_literal: true

class TagsController < ApplicationController
  def index
    @tags = Tag.limit(10)

    render json: @tags
  end

  def show
    @tag = Tag.find(params[:id])

    render json: @tag
  end
end
