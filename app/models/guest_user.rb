class GuestUser
  def name
    'Guest'
  end

  def email
    ""
  end

  def guest?
    true
  end

  def admin?
    false
  end

  def signed_in?
    false
  end

  def registered?
    false
  end

  def id
  end

  def activation_tokens
    []
  end
end
