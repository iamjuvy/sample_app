class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update, :index]	
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,     only:  :destroy   

  def show
	@user = User.find(params[:id])
        @microposts = @user.microposts.paginate(page: params[:page])
        #@microposts = Micropost.paginate(page: params[:page])
  end

  def new
	@user = User.new
  end

  def create
	@user = User.new(params[:user])
	if @user.save		
	    #Handle a successful save.
	    sign_in @user
	    flash[:success] = "Welcome to the Sample App!"
	    redirect_to @user
	else
	    render 'new'
        end
  end
 
  def edit
  end

  def update
	if @user.update_attributes(params[:user])
	    flash[:success] = "Profile updated"
	    sign_in @user
	    redirect_to @user	
	else
	    render 'edit'
	end
  end

  def index
	@users = User.paginate(page: params[:page])
  end

  def destroy
	@user = User.find(params[:id])
	@user.destroy
        flash[:success] = "User " + @user.name + " destroyed"
	redirect_to users_url
  end

  private

	#def signed_in_user
	#   unless signed_in?
	#	store_location
	#        redirect_to signin_url, notice: "Please sign in."
	#   end
	#end

	def correct_user
	     @user = User.find(params[:id])
	     redirect_to(root_path) unless current_user?(@user)	
	end

        def admin_user
	     redirect_to(root_path) unless current_user.admin?
        end

end
