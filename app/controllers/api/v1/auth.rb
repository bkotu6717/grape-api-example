module API
  module V1
    class Auth < Grape::API
      include API::V1::Defaults

      resource :user do
        desc "Signup user"
        params do
          requires :user, type: Hash do
            requires :email, type: String
            requires :password, type: String
            requires :password_confirmation, type: String
          end
        end
        post "register" do
          user = User.find_by_email(permitted_params[:user][:email])
          res = {}
          if user
            res = { error: 'Email already taken', status: 422 }
          else
            user = User.new(permitted_params[:user])
            if user.save
              res = { success: 'You have successfully registered with us. Please send the access token generated for every subsequest api call.',
                      status: 200, 
                      access_token: user.api_key.access_token 
                    }
            else
              res  = { error: user.errors.to_hash, status: 422 }
            end
            present res
          end 
        end

        desc "Signin user"
        params do
          requires :user, type: Hash do
            requires :email, type: String
            requires :password, type: String
          end
        end
        post "authorize" do
          user = User.find_by_email(permitted_params[:user][:email])
          res = {}
          if user && user.authenticate(permitted_params[:user][:password])
            res = { success: 'You have successfully loggedin.', access_token: user.api_key.access_token, status: 200 }
          else
            res = { error: 'Invalid credentails.', status: 401 }
          end
          present res
        end
      end
    end
  end
end