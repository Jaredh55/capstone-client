class Client::PostsController < ApplicationController
  def index
    response = Unirest.get("http://localhost:3000/api/posts")
    @posts = response.body
    render 'index.html.erb'
  end

  def new
    @post = {}
    render 'new.html.erb'
  end

  def create
    @post = {
                     'title' => params[:title],
                     'content' => params[:content],
                     'latitude' => params[:latitude],
                     'longitude' => params[:longitude]
                    }

    response = Unirest.post(
                            "http://localhost:3000/api/posts",
                            parameters: @post
                            )

    if response.code == 200
      flash[:success] = "Successfully created Post"
      redirect_to "/client/posts/"
    elsif response.code == 401
      flash[:warning] = "You are not authorized to make a post"
      redirect_to '/'
    elsif 
      @errors = response.body['errors']
      render 'new.html.erb'
    end
  end

  def show
    post_id = params[:id]
    response = Unirest.get("http://localhost:3000/api/posts/#{post_id}")
    @post = response.body
    render 'show.html.erb'
  end

  def edit
    response = Unirest.get("http://localhost:3000/api/posts/#{params[:id]}")
    @post = response.body
    render 'edit.html.erb'
  end

  def update
    @post = {
                      'id' => params[:id],
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
    response = Unirest.delete("http://localhost:3000/api/posts/#{params['id']}")
    if response.code == 200
    flash[:success] = "Successfully removed post"
    redirect_to "/client/posts"
    else
      flash[:warning] = "You are not authorized"
      redirect_to '/'
    end
  end
end
