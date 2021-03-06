# frozen_string_literal: true

module ApplicationHelper
  def gravatar_for(user, size = 30, title = user.name)
  image_tag gravatar_image_url(user.email, size: size), title: title, class: 'img-rounded', alt: 'profile-pic'
  end
end
