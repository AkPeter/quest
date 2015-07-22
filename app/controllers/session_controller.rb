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
              redirect_to root_url
            else
              redirect_to payment_url
          end
        else
          redirect_to personal_page_url
        end
      else
        render :template => 'users/signin', :locals => {:uid => @user.id}
      end
    else
      respond_to do |format|
        format.html { redirect_to :back, notice: 'такого email нет в системе, зарегистрируйтесь' }
        format.json { head :no_content }
      end
    end
  end

  def logout
    # session[:uid], session[:tid] = nil
    reset_session
    redirect_to root_url
  end
end