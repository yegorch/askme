module ApplicationHelper
  def user_avatar(user)
    user.avatar_url.presence || asset_pack_path('media/images/avatar.jpg')
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
