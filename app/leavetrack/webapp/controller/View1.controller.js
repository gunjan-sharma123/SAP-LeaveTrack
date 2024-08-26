sap.ui.define([
    "sap/ui/core/mvc/Controller",
      "sap/ui/core/Fragment"
],
function (Controller , Fragment) {
    "use strict";

    return Controller.extend("com.leavetrack.leavetrack.controller.View1", {
      
        onApplyLeavePress: function() {
            if (!this._oLeaveDialog) {
                Fragment.load({
                    name: "com.leavetrack.leavetrack.view.fragment.ApplyLeave",
                    controller: this
                }).then(function(oFragment) {
                    this._oLeaveDialog = oFragment;
                    this.getView().addDependent(this._oLeaveDialog);
                    this._oLeaveDialog.open();
                }.bind(this));
            } else {
                this._oLeaveDialog.open();
            }
        },
        onSubmit: function () {
            // Get the data from the fragment controls
            var oSelect = this.byId("leaveTypeSelect");
            var oStartDatePicker = this.byId("startDatePicker");
            var oEndDatePicker = this.byId("endDatePicker");
            var oReasonTextArea = this.byId("reasonTextArea");
        
            var sLeaveType = oSelect.getSelectedItem().getText();
            var sStartDate = oStartDatePicker.getValue();
            var sEndDate = oEndDatePicker.getValue();
            var sReason = oReasonTextArea.getValue();
        
            // Prepare the payload
            var oPayload = {
                LeaveType: sLeaveType,
                StartDate: sStartDate,
                EndDate: sEndDate,
                Reason: sReason
            };
        
            // Send the data to CAP service
            $.ajax({
                url: "/LeaveService/LeaveApplication",
                type: "POST",
                contentType: "application/json",
                data: JSON.stringify(oPayload),
                success: function () {
                    sap.m.MessageBox.success("Leave applied successfully and Pending for approval", {
                        title: "Success",
                        onClose: function () {
                            // Logic to execute after the message box is closed
                        }
                    });
        
                    // Close the dialog
                    if (this._oLeaveDialog) {
                        this._oLeaveDialog.close();
                    }
                }.bind(this),
                error: function (xhr, textStatus, errorThrown) {
                    sap.m.MessageBox.error("Error while applying leave: " + errorThrown);
                }
            });
        }
    });
});
