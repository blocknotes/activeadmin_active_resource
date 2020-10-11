# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :load_record, only: %w[show update destroy]

  def index
    @posts = Post.limit(10)

    render json: @posts
  end

  def show
    render json: @post
  end

  def create
    @post = Post.new(params[:post].permit!)
    success = @post.save
    result = success ? { success: true } : { success: false, errors: @post.errors.messages }

    render json: result, status: success ? :ok : :unprocessable_entity
  end

  def update
    success = @post.update(params[:post].permit!)
    result = success ? { success: true } : { success: false, errors: @post.errors.messages }

    render json: result, status: success ? :ok : :unprocessable_entity
  end

  def destroy
    success = @post.destroy
    result = success ? { success: true } : { success: false, errors: @post.errors.messages }

    render json: result, status: success ? :ok : :unprocessable_entity
  end

  private

  def load_record
    @post = Post.find(params[:id])
  end
end
