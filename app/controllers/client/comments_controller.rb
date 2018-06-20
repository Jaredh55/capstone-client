class Client::CommentsController < ApplicationController
  def create
    client_params = {
                           content: params[:content],
                           post_id: params[:post_id]
                    }

    response = Unirest.post(
                            "http://localhost:3000/api/comments",
                            parameters: client_params
                            )
    @comment = response.body
    post_id = params[:post_id]
    redirect_to "/client/posts/#{post_id}"
  end

  def destroy #still working on this show.html.erb not working
    post_id = params[:post_id]
    comment_id = params[:id]

    response = Unirest.delete("http://localhost:3000/api/comments/#{comment_id}")
    redirect_to "/client/posts/#{post_id}"
  end
end
