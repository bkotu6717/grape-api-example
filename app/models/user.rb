class User < ApplicationRecord
  has_secure_password
  has_one :api_key
  before_save :generate_api_key
  
  private

  def generate_api_key
    begin
      access_token = SecureRandom.hex
      build_api_key(access_token: access_token)
    end while api_key.class.exists?(access_token: access_token)
  end  
end
