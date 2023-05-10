# frozen_string_literal: true

require 'jwt'

module JwtToken
  extend ActiveSupport::Concern
  HMAC_SECRET = Rails.application.secrets.secret_key_base

  def self.encode(payload, exp = 1.minute.from_now.to_i)
    payload[:exp] = exp
    JWT.encode(payload, HMAC_SECRET)
  end

  def self.decode(token)
    decoded = JWT.decode(token, HMAC_SECRET, true, { algorithm: 'HS256' })
    HashWithIndifferentAccess.new(decoded[0])
  end
end
