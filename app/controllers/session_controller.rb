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
              redirect_to root_url, notice: flash.first.msg
            else
              redirect_to payment_url, notice: flash.first.msg
          end
        else
          redirect_to personal_page_url, notice: 'Билет зарезервирован за Вами'
        end
      else
        render :template => 'users/signin', :locals => {:uid => @user.id}
      end
    else
      redirect_to signin_path, notice: 'такого email нет в системе, зарегистрируйтесь'
    end
  end

  def logout
    # session[:uid], session[:tid] = nil
    reset_session
    redirect_to root_url
  end
end