module ApplicationHelper

  def edit_and_destroy_buttons(item)
    if current_user
      edit = link_to('Edit', url_for([:edit, item]), class:"btn btn-xs btn-warning")
      if current_user.admin?
        del = link_to('Destroy', item, method: :delete,
                      data: {confirm: 'Are you sure?' }, class:"btn btn-xs btn-danger")
      end
    end
    raw("#{edit} #{del}")
  end

end
