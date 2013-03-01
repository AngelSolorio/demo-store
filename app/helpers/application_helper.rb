module ApplicationHelper
  def display_current_admin
    return unless admin_logged?

    message = t('.welcome', email: current_admin.try(:email))
    message << ' | '
    message << link_to(t('.logout'), backend_session_destroy_path, method: :delete, class: 'logout')
    message.html_safe
  end

  def display_alert
    content_tag :div, class: 'alert' do
      flash[:alert]
    end if flash[:alert]
  end
end
