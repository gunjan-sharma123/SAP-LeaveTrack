namespace app.Leave;

using { cuid, managed ,sap.common.CodeList } from '@sap/cds/common';

entity Employee :cuid, managed {    
firstName     : String;
lastName      : String;
Emp_Name          : String = firstName || ' ' || lastName;
DOB : Date;
Address : String(100);
email         : String;
phone         : String;
}

entity LeaveType :cuid , managed{
  LeaveTypeName  : String;
  Description    : String;
}


entity LeaveRequest : cuid , managed{
  Employee         : Association to Employee;
  LeaveType        : Association to LeaveType;
  StartDate        : DateTime;
  EndDate          : DateTime;
  Reason           : String;
  Status           : Association to Status default 'N';
  SubmissionDate   : DateTime;
  ManagerApproval  : Boolean default false;
  ManagerComment   : String;
  NotificationSend : Boolean default false;
}

entity Status : CodeList {
key code: String enum {
    new = 'N';
    pending = 'P'; 
    approved = 'A'; 
    rejected = 'R'; 
};
}

entity Manager : cuid, managed{
  Employee    : Association to Employee;
}

entity HR  : cuid, managed{
  Employee : Association to Employee;
  Manager  : Association to Manager
}

