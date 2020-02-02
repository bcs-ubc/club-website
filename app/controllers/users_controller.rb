class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :destroy_photo]
  before_action :require_permissions, only: [:index, :show, :edit]

  # GET /users
  # GET /users.json
  def index
    @users = User.paginate(page: params[:page], per_page: 7)
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "Welcome to Click-Feed  #{@user.username}!"
      session[:user_id] = @user.id
      redirect_to "/#{@user.id}"
    else
      render 'new'
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        sign_in(@user, :bypass => true)
        format.html { redirect_to "/#{@user.id}" }
        flash[:success] = "Your profile was successfully updated."
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    session[:user_id] = nil if current_user == @user
    respond_to do |format|
      format.html { redirect_to users_path }
      flash[:danger] = "#{@user.username} and their articles were successfully deleted."
      format.json { head :no_content }
    end
  end

  def destroy_photo
      @user.avatar.purge
      respond_to do |format|
        format.html { redirect_to "/#{@user.id}" }
        flash[:success] = "Your profile photo has been successfully deleted."
        format.json { head :no_content }
      end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :email, :password, :admin, :avatar)
    end

    def require_permissions
      if (@user != current_user && !admin?) || !user_signed_in?
        flash[:danger] = "You do not have permissions to perform that action"
        redirect_back(fallback_location: root_path)
      end
    end
end
