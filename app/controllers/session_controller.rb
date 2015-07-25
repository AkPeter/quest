class SessionController < ApplicationController
  include TicketsLib

  def signin
    @user = User.find_by_email(params[:email])
    if @user
      if @user.authenticate(params[:password])
        session[:uid] = @user.id
        if session[:tid]
          case reserveTicket session[:tid]
            when  'root'
              flash.keep
              redirect_to root_url
            else
              flash.keep
              redirect_to payment_url
          end
        else
          flash.keep
          redirect_to personal_page_url
        end
      else
        flash[:notice] = 'неправильный пароль, воспользуйтесь восстановлением пароля'
        render :template => 'users/signin', :locals => {:uid => @user.id}
      end
    else
      redirect_to signin_path, notice: 'такого email нет в системе, зарегистрируйтесь'
    end
  end

  def logout
    reset_session
    flash[:notice] = 'Заходите ещё !'
    redirect_to root_url
  end

end