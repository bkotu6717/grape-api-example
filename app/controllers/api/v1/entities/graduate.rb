module API
  module V1
    module Entities
      class Graduate < Grape::Entity
        expose :name
        expose :id
      end
    end
  end
end