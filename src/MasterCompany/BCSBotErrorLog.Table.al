table 88007 "BCS Bot Error Log"
{
    Caption = 'BCS Bot Error Log';
    DataClassification = ToBeClassified;
    DataPerCompany = false;

    //TODO: Clean up table

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = SystemMetadata;
            AutoIncrement = true;
        }

        field(2; "Company Name"; Text[100])
        {
            Caption = 'Company Name';
            DataClassification = SystemMetadata;
        }

        field(5; "Error Type"; Enum "BCS Error Type")
        {
            Caption = 'Error Type';
            DataClassification = SystemMetadata;
        }

        field(10; "Bot Instance"; Integer)
        {
            Caption = 'Bot Instance';
            DataClassification = SystemMetadata;
        }
        field(11; "Bot Type"; Enum "BCS Bot Type")
        {
            Caption = 'Bot Type';
            DataClassification = SystemMetadata;
        }
        field(20; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = SystemMetadata;
        }
        field(50; "Error Message"; Text[200])
        {
            Caption = 'Error Message';
            DataClassification = SystemMetadata;
        }

        field(60; "Acknowledged"; Boolean)
        {
            Caption = 'Acknowledged';
            DataClassification = SystemMetadata;
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }

    procedure DeleteOldEntries(DaysOld: Integer)
    var
        BotErrorLog2: Record "BCS Bot Error Log";
        BeforeDate: Date;
    begin
        BotErrorLog2.SetRange(Acknowledged, false);  //Anything that need Ack should stay
        BeforeDate := CalcDate(StrSubstNo('<-%1d>', DaysOld), Today);
        BotErrorLog2.SetRange("Posting Date", 0D, BeforeDate);
        BotErrorLog2.DeleteAll();
    end;

}
