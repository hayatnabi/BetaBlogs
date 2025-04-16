module ApplicationHelper
  def flash_class(level)
    case level.to_sym
    when :notice then "alert-success"
    when :alert then "alert-danger"
    else "alert-info"
    end
  end

  def gravatar_for(user, options = { size: 80 })
    email_address = user.email.downcase
    hash = Digest::MD5.hexdigest(email_address)
    size = options[:size]
    gravatar_url = "https://www.gravatar.com/avatar/#{hash}?s=#{size}"
    image_tag(gravatar_url, alt: user.username, class: "rounded shadow mx-auto d-block")
  end
end
