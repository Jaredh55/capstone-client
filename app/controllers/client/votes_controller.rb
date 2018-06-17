class Client::VotesController < ApplicationController
  def create
    client_params = {
                           votable_id: params[:votable_id],
                           positive: params[:positive]
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

  def update
    @vote = {
                    'post_id' => params[:id],
                     'title' => params[:title],
                     'content' => params[:content],
                     'latitude' => params[:latitude],
                     'longitude' => params[:longitude],
                     'visit' => params[:visit_id]
                    }

    response = Unirest.patch(
                            "http://localhost:3000/api/posts/#{params[:id]}",
                            parameters: @post
                            )

    if response.code == 200
      flash[:success] = "Successfully updated Post"
      redirect_to "/client/posts/#{params[:id]}"
    elsif response.code == 401
      flash[:warning] = "You are not authorized to update a post"
      redirect_to '/'
    else
      @errors = response.body['errors']
      render 'edit.html.erb'
    end
  end

  def destroy
    post_id = params[:id]
    response = Unirest.delete("http://localhost:3000/api/votes/#{post_id}") #response just holds value of return, action would still work without it
    # render '/views/client/posts/show.html.erb'
    redirect_to "/client/posts/#{post_id}"
  end
end
