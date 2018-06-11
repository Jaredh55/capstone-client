class UsersController < ApplicationController

  def index
    response = Unirest.get("http://localhost:3000/users")
    @users = response.body
    render 'index.html.erb'
  end

  def new
    render 'new.html.erb'
  end

  def create
    client_params = {
                      username: params[:username],
                      bio: params[:bio],
                      password: params[:password],
                      password_confirmation: params[:password_confirmation]
                      }

    response = Unirest.post(
                            "http://localhost:3000/users",
                            parameters: client_params
                            )
    
    if response.code == 200
      session[:user_id] = response.body["id"]
      flash[:success] = 'Successfully created account!'
      redirect_to '/'
    else
      flash[:warning] = 'Invalid email or password!'
      redirect_to '/signup'
    end
  end

  def edit
    response = Unirest.get("http://localhost:3000/users/#{params[:id]}")
    @user = response.body
    render 'edit.html.erb'
  end

  def show
    user_id = params[:id]
    response = Unirest.get("http://localhost:3000/users/#{user_id}")
    @user = response.body
    render 'show.html.erb'
  end

  def update
    @user = {
                      'id' => params[:id],
                     'username' => params[:username],
                     'bio' => params[:bio]
                    }

    response = Unirest.patch(
                            "http://localhost:3000/users/#{params[:id]}",
                            parameters: @user
                            )

    if response.code == 200
      flash[:success] = "Successfully updated Profile"
      redirect_to "/users/#{params[:id]}"
    elsif response.code == 401
      flash[:warning] = "You are not authorized to update this profile"
      redirect_to '/'
    else
      @errors = response.body['errors']
      render 'edit.html.erb'
    end
  end

  def destroy
    response = Unirest.delete("http://localhost:3000/users/#{params['id']}")
    if response.code == 200
    flash[:success] = "Successfully removed profile"
    redirect_to "/"
    else
      flash[:warning] = "You are not authorized"
      redirect_to '/'
    end
  end
end
