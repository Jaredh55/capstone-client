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
    user_id = params[:id]

    client_params = {
                      city_id: params[:city_id]
                      }
    response = Unirest.delete("http://localhost:3000/api/votes/#{user_id}", parameters: client_params)
    redirect_to '/users'
  end
end
