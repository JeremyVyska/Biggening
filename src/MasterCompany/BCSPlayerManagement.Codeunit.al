codeunit 88015 "BCS Player Management"
{
    procedure SetupNewPlayer(var Player: Record "BCS Player")
    var
        IsMasterCompany: Codeunit "BCS Is Master Company";
        NotMasterCompanyErr: Label 'Please run this from a Master Company.';
    begin
        if not IsMasterCompany.IsMC() then
            Error(NotMasterCompanyErr);

        Player.TestField("Company Name");

        // New Company
        if not (Player."Step - Company Made") then begin
            GeneratePlayerCompany(Player);
            Player."Step - Company Made" := true;
            Player.Modify(true);
            Commit();
        end;

        // New User
        if not (Player."Step - User Made") then begin
            GeneratePlayerUser(Player);
            Player."Step - User Made" := true;
            Player.Modify(true);
            Commit();
        end;

        //TODO: User Permissions.  Ugh.

        if not (Player."Step - Master Data Copy") then begin
            CopyMasterCompanySetup(Player."Company Name");
            Player."Step - Master Data Copy" := true;
            Player.Modify(true);
            Commit();
        end;

        if not (Player."Step - Job Queues Made") then begin
            GenerateInitialCompanySettingsJob(Player);
            Commit();

            CreateJobQueueInCompany(Player);
            Player."Step - Job Queues Made" := true;
            Player.Modify(true);
            Commit();
        end;

        Message(SetupCompletedMsg);
    end;

    local procedure GeneratePlayerCompany(var Player: Record "BCS Player")
    var
        Company: Record Company;
    begin
        Player.TestField("Company Name");
        if (not Company.Get(Player."Company Name")) then begin
            Company.Init();
            Company.Name := Player."Company Name";
            if (Player."Company Display Name" <> '') then
                Company."Display Name" := Player."Company Display Name";
            Company.Insert(true);
        end else
            Error(CompanyAlreadyExistsErr, Player."Company Name");
    end;

    local procedure GeneratePlayerUser(var Player: Record "BCS Player")
    var
        User: Record User;
    begin
        Player.TestField("User Name");
        if (IsNullGuid(Player."User ID")) then begin
            User.Init();
            User."User Security ID" := CreateGuid();
            user."User Name" := Player."User Name";
            User."Full Name" := Player."Name";
            User.Insert(true);

            Player."User ID" := User."User Security ID";
            Player.Modify(true);
        end else
            Error(UserAlreadyExistsErr);
    end;

    local procedure CreateJobQueueInCompany(var Player: Record "BCS Player")
    var
        JobQueueEntry: Record "Job Queue Entry";
    begin
        JobQueueEntry.ChangeCompany(Player."Company Name");
        JobQueueEntry."Object Type to Run" := JobQueueEntry."Object Type to Run"::Codeunit;
        JobQueueEntry."Object ID to Run" := Codeunit::"BCS Player Heartbeat Listener";
        JobQueueEntry.Insert(true);
        JobQueueEntry."User ID" := Player."User ID";
        JobQueueEntry."Starting Time" := 0T;
        JobQueueEntry."Ending Time" := 235959T;
        JobQueueEntry."Recurring Job" := true;
        JobQueueEntry."Run on Mondays" := true;
        JobQueueEntry."Run on Tuesdays" := true;
        JobQueueEntry."Run on Wednesdays" := true;
        JobQueueEntry."Run on Thursdays" := true;
        JobQueueEntry."Run on Fridays" := true;
        JobQueueEntry."Run on Saturdays" := true;
        JobQueueEntry."Run on Sundays" := true;
        JobQueueEntry."No. of Minutes between Runs" := 1;  //most of the time, will do nearly nothing.
        JobQueueEntry."Earliest Start Date/Time" := CurrentDateTime() + (10 * 60 * 1000);
        JobQueueEntry.VALIDATE(Status, JobQueueEntry.Status::Ready);
        JobQueueEntry.Modify(true);
    end;

    local procedure CopyMasterCompanySetup(CompanyName: Text[30])
    var
        MasterCoCopy: Codeunit "BCS Master Company";
    begin
        MasterCoCopy.CopySetupToCompany(CompanyName);
    end;

    local procedure GenerateInitialCompanySettingsJob(var Player: Record "BCS Player")
    var
        JobQueueEntry: Record "Job Queue Entry";
    begin
        JobQueueEntry.ChangeCompany(Player."Company Name");
        JobQueueEntry."Object Type to Run" := JobQueueEntry."Object Type to Run"::Codeunit;
        JobQueueEntry."Object ID to Run" := Codeunit::"BCS Player Starting Values";
        JobQueueEntry.Insert(true);
        //JobQueueEntry."User ID" := Player."User ID";
        JobQueueEntry."User ID" := UserId; // This needs to run as Admin to update the Player table.
        JobQueueEntry."Recurring Job" := false;
        JobQueueEntry."Earliest Start Date/Time" := CurrentDateTime() + (30 * 1000);
        JobQueueEntry.Validate(Status, JobQueueEntry.Status::Ready);
        JobQueueEntry.Modify(true);
    end;


    procedure RemovePlayerCompany(var Player: Record "BCS Player")
    var
        Company: Record Company;
    begin
        Player.TestField("Company Name");
        if Company.Get(Player."Company Name") then
            Company.Delete(true);
        Commit();
        Player."Step - Company Made" := false;
        Player."Step - Init. Job Ran" := false;
        player."Step - Master Data Copy" := false;
        Player."Step - Job Queues Made" := false;
        Player.Modify(true);
    end;


    procedure SetIsAdmin(): Boolean
    var
        Player: Record "BCS Player";
    begin
        Player.SetRange("User Name", UserId());
        exit(Player.FindFirst() and (Player."System Permissions" in [Player."System Permissions"::Admin]));
    end;


    /*
 
 888     888     d8888 8888888b.   .d8888b.  
 888     888    d88888 888   Y88b d88P  Y88b 
 888     888   d88P888 888    888 Y88b.      
 Y88b   d88P  d88P 888 888   d88P  "Y888b.   
  Y88b d88P  d88P  888 8888888P"      "Y88b. 
   Y88o88P  d88P   888 888 T88b         "888 
    Y888P  d8888888888 888  T88b  Y88b  d88P 
     Y8P  d88P     888 888   T88b  "Y8888P"  
       
*/

    var
        CompanyAlreadyExistsErr: Label 'The Player''s Company "%1" already exists';
        UserAlreadyExistsErr: Label 'The Player already has a User.';
        SetupCompletedMsg: Label 'Setup completed.';
}
