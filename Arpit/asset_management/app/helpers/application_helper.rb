module ApplicationHelper
	def active_menu(controller_name)
		cont_name = controller.controller_name
		status = 	case controller_name 
					when 'devices'
						'active' if(cont_name == 'software_products' || cont_name== 'devices' || cont_name== 'device_categories')
					when 'partners'
						'active' if(cont_name == 'users' || cont_name== 'vendors' || cont_name== 'employees' || cont_name== 'projects'  || cont_name== 'clients')
					when 'transfers'
						'active' if(cont_name == 'transfers')
					when 'device_requests'
						'active' if(cont_name == 'device_requests')
					when 'locations'
						'active' if(cont_name == 'branches')
					when 'reports'
						'active' if(cont_name == 'controller_name')
					else
						''
					end					
	end

	def active_sub_menu(controller_name,resource=nil,action=nil)
		if resource == nil
			controller.controller_name == controller_name ? 'active' : ''
		elsif params[:resource].present?
			(controller.controller_name == controller_name) && params[:resource] == resource ? 'active' : ""
		end
	end

	def deleted_helper
		'Deleted ' if params[:deleted]
	end

	def deleted_on_th
		content_tag(:th, "Deleted On", class: "span6") if params[:deleted].present?
	end

	def actions_th
		obj_actions = params[:deleted].present? ? "Revert" : "Actions"
		content_tag(:th, obj_actions, class: "action")
	end

	def deleted_at(obj)
		content_tag(:td, obj.deleted_at.try(:to_s,"%b %d, %Y %I:%M %p")) if params[:deleted].present?
	end

	def format_value(value)
		value.present? ? value : '-' 
	end
end
