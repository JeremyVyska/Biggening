codeunit 88015 "BCS Player Management"
{
    procedure SetupNewPlayer(var Player: Record "BCS Player")
    var
        IsMasterCompany: Codeunit "BCS Is Master Company";
    begin
        if not IsMasterCompany.IsMC() then
            //TODO: Error with feedback
            exit;

        // New Company
        GeneratePlayerCompany(Player);
        Commit();

        // New User
        GeneratePlayerUser(Player);
        Commit();

        //TODO: User Permissions

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
