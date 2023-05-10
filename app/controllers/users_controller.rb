# frozen_string_literal: true

class UsersController < ApplicationController
  skip_before_action :authenticate_user, only: [:create]
  before_action :find_user, only: %i[show update destroy]

  def index
    @user = User.all
    render json: @user, status: 200
  end

  def show
    render json: @user, status: 200
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: 201
    else
      render json: { errors: @user.errors.full_messages }, status: 503
    end
  end

  def update
    return if @user.update(user_params)

    render json: { errors: @user.errors.full_messages }, status: 503
  end

  def destroy
    @user.destroy
  end

  private

  def user_params
    params.permit(:user_name, :email, :password)
  end

  def find_user
    @user = User.find_by_id(params[:id])
  end
end
