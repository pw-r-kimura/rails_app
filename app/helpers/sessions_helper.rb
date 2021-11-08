module SessionsHelper

  # $BEO$5$l$?%f!<%6!<$G%m%0%$%s$9$k(B
  def log_in(user)
    session[:user_id] = user.id
  end

  # $B%f!<%6!<$N%;%C%7%g%s$r1JB3E*$K$9$k(B
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # $B8=:_%m%0%$%sCf$N%f!<%6!<$rJV$9(B($B$$$k>l9g(B)
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  # $B%f!<%6!<$,%m%0%$%s$7$F$$$l$P(Btrue$B!"$=$NB>$J$i(Bfalse$B$rJV$9!#(B
  def logged_in?
    !current_user.nil?
  end

  # $B8=:_$N%f!<%6!<$r%m%0%"%&%H$9$k(B
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
