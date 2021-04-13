module ApplicationHelper
  def user_avatar(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      asset_path 'avatar.jpg'
    end
  end

  def sklonyator(count, one, two, five)
    case count % 100
    when 11..14 then five
    end

    case count % 10
    when 1 then one
    when 2..4 then two
    else five
    end
  end

  def fa_icon(icon_class)
    content_tag 'span', '', class: "fa fa-#{icon_class}"
  end
end
