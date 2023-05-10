# frozen_string_literal: true

class AuthenticationController < ApplicationController
  skip_before_action :authenticate_user

  def login
    @user = User.find_by_email(params[:email])
    # binding.pry
    if @user&.authenticate(params[:password])
      time = Time.now + 1.minutes.to_i
      token = JwtToken.encode(user_id: @user.id)
      render json: { token:, exp: time.strftime('%m-%d-%Y %H:%M'),
                     username: @user.user_name }, status: :ok
    else
      render json: { errors: 'unauthorized' }, status: :unauthorized
    end
  end
end
