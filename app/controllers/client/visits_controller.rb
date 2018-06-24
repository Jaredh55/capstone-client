class Client::VisitsController < ApplicationController
  def create
    client_params = {
                           country: params[:country],
                           city: params[:city]
                    }

    response = Unirest.post(
                            "http://localhost:3000/api/visits",
                            parameters: client_params
                            )
    @visit = response.body
    # post_id = params[:votable_id]
    # render '/views/client/posts/show.html.erb'
    redirect_to '/users'

  end

  def destroy #still working on this show.html.erb not working
    user_id = params[:user_id]
    visit_id = params[:id]

    response = Unirest.delete("http://localhost:3000/api/visits/#{visit_id}")
    redirect_to "/users/#{user_id}"
  end
end
