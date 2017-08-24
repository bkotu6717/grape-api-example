module API
  module V1
    class Graduates < Grape::API
      include API::V1::Defaults

      resource :graduates do
        desc "Return all graduates"
        get "", root: :graduates do
          present :graduates, Graduate.all, with: API::V1::Entities::Graduate
        end

        desc "Return a graduate"
        params do
          requires :id, type: String, desc: "ID of the 
            graduate"
        end
        get ":id", root: "graduate" do
          present :graduate, Graduate.where(id: permitted_params[:id]).first!, with: API::V1::Entities::Graduate 
        end
      end
    end
  end
end