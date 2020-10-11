# frozen_string_literal: true

class AuthorsController < ApplicationController
  before_action :load_record, only: %w[show update destroy]

  def index
    @authors = Author.limit(10)

    render json: @authors
  end

  def show
    render json: @author
  end

  def create
    @author = Author.new(params[:author].permit!)
    success = @author.save
    result = success ? { success: true } : { success: false, errors: @author.errors.messages }

    render json: result, status: success ? :ok : :unprocessable_entity
  end

  def update
    success = @author.update(params[:author].permit!)
    result = success ? { success: true } : { success: false, errors: @author.errors.messages }

    render json: result, status: success ? :ok : :unprocessable_entity
  end

  def destroy
    success = @author.destroy
    result = success ? { success: true } : { success: false, errors: @author.errors.messages }

    render json: result, status: success ? :ok : :unprocessable_entity
  end

  private

  def load_record
    @author = Author.find(params[:id])
  end
end
