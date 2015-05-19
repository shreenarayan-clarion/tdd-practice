module TransfersHelper

  def help_text(transfer)
    transfer.transferable_type == "Employee" ? "Must be after joining date" : "Must be after purchase date"
  end

end
