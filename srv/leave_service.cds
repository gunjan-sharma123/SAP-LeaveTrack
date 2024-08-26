using { app.Leave } from '../db/leave_schema';

service LeaveManagementService  {

  entity LeaveType  @(restrict: [
    {
      grant: ['READ'],
      to: ['Employee']
    }
  ]) as projection on Leave.LeaveType;
  entity LeaveRequest  @(restrict: [
    {
      grant: ['READ', 'CREATE', 'UPDATE', 'DELETE'],
      to: ['Employee']
    },
    {
      grant: ['READ', 'CREATE', 'UPDATE', 'DELETE'],
      to: ['Manager']
    },
    {
      grant: ['READ', 'UPDATE'],
      to: ['HR']
    }
  ])as projection on Leave.LeaveRequest;

  // @onboarded
  // action submitLeaveRequest(
  // EmpId:UUID,
  // StartDate        : DateTime,
  // EndDate          : DateTime,
  // Reason           : String,
  // SubmissionDate   : DateTime,
  // );



  @readonly
  entity Manager as projection on Leave.Manager;

  @readonly
  entity HR as projection on Leave.HR

  @readonly
  entity Employees as projection on Leave.Employee;
  


}
