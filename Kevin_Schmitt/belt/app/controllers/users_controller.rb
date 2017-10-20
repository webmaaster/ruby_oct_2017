class UsersController < ApplicationController
  def index
    if current_user
      return redirect_to logged_in_path
    end
    return render 'users/index'
  end

  def show
    if current_user
      @ideas = Idea.all #be sure to order by likes 
      return render 'users/show'
    end
    # if current_user
    #   @ideas = Idea.select('*, COUNT(*) as count').joins(:likes).order('like') #be sure to order by likes 
    #   return render 'users/show'
    # end
    return redirect_to root_path
  end

  def create
    user = User.create(user_params)
    if user.valid?
        session[:user_id] = user.id

        return redirect_to logged_in_path
    end
    flash[:errors] = user.errors.full_messages
    redirect_to :back
  end

  def showone
    if current_user
      @user = User.find(params[:id])
      if @user
        return render('users/showone')
      end
      return redirect_to(:back)
    end
    return redirect_to(root_path)
  end





  private
  def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :alias, :password, :password_confirmation)
  end
end
