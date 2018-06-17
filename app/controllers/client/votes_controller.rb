class Client::VotesController < ApplicationController
  def create
    client_params = {
                           votable_id: params[:votable_id]
                    }

    response = Unirest.post(
                            "http://localhost:3000/api/votes",
                            parameters: client_params
                            )
    @vote = response.body
    post_id = params[:votable_id]
    # render '/views/client/posts/show.html.erb'
    redirect_to "/client/posts/#{post_id}"

  end

  def destroy
    post_id = params[:id]
    response = Unirest.delete("http://localhost:3000/api/votes/#{post_id}") #response just holds value of return, action would still work without it
    # render '/views/client/posts/show.html.erb'
    redirect_to "/client/posts/#{post_id}"
  end
end
