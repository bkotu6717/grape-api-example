module API  
  module V1
    module Defaults
      extend ActiveSupport::Concern

      included do
        prefix "api"
        version "v1", using: :path
        default_format :json
        format :json
        # formatter :json, 
        # Grape::Formatter::ActiveModelSerializers

        helpers do
          def permitted_params
            @permitted_params ||= declared(params, include_missing: false)
            @permitted_params.to_hash.with_indifferent_access
          end

          def logger
            Rails.logger
          end

          def current_user
            return unless request.headers['Access-Token'].present?
             @user ||= ApiKey.find_by_access_token(request.headers['Access-Token'])
            return unless @user
            @user
          end
        end

        rescue_from ActiveRecord::RecordNotFound do |e|
          error_response(message: e.message, status: 404)
        end

        rescue_from ActiveRecord::RecordInvalid do |e|
          error_response(message: e.message, status: 422)
        end
      end
    end
  end
end