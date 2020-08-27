table 88004 "BCS Game Setup"
{
    DataPerCompany = false;
    DataClassification = SystemMetadata;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = SystemMetadata;
        }

        field(10; "Game Date"; Date)
        {
            Caption = 'Game Date';
            DataClassification = SystemMetadata;
        }

        field(20; "Purchase Prospect Effort"; Integer)
        {
            Caption = 'Purchase Prospect Effort';
            DataClassification = SystemMetadata;
        }
        field(21; "Purch. Pros. Tier Multiplier"; Decimal)
        {
            Caption = 'Purch. Pros. Tier Multiplier';
            DataClassification = SystemMetadata;
            InitValue = 1;
        }
        field(22; "Purch. Pros. Base Max Orders"; Integer)
        {
            Caption = 'Purch. Pros. Base Max Orders';
            DataClassification = SystemMetadata;
            InitValue = 10;
        }
        field(23; "Purch. Pros. Base Max Quantity"; Integer)
        {
            Caption = 'Purch. Pros. Base Max Quantity';
            DataClassification = SystemMetadata;
            InitValue = 50;
        }

        field(30; "Sales Prospect Effort"; Integer)
        {
            Caption = 'Sales Prospect Effort';
            DataClassification = SystemMetadata;
        }
        field(31; "Sales Pros. Tier Multiplier"; Decimal)
        {
            Caption = 'Sales Pros. Tier Multiplier';
            DataClassification = SystemMetadata;
            InitValue = 1;
        }
        field(32; "Sales Pros. Base Max Orders"; Integer)
        {
            Caption = 'Sales Pros. Base Max Orders';
            DataClassification = SystemMetadata;
            InitValue = 10;
        }
        field(33; "Sales Pros. Base Max Quantity"; Integer)
        {
            Caption = 'Sales Pros. Base Max Quantity';
            DataClassification = SystemMetadata;
            InitValue = 50;
        }

        field(40; "Location No. Series"; Code[20])
        {
            Caption = 'Location No. Series';
            DataClassification = SystemMetadata;
            TableRelation = "No. Series";
        }

        field(44; "Basic Loc. Max. Bots"; Integer)
        {
            Caption = 'Basic - Maximum Bots';
            DataClassification = SystemMetadata;
            BlankZero = true;

            trigger OnValidate()
            var
                Location: Record Location;
            begin
                UpdateAllLocations(Location.FieldNo("Maximum Bots"), Location.FieldCaption("Maximum Bots"), "Basic Loc. Max. Bots", true);
            end;
        }
        field(45; "Basic Loc. Max. Units"; Decimal)
        {
            Caption = 'Basic - Maximum Units';
            DataClassification = SystemMetadata;
            BlankZero = true;
            DecimalPlaces = 0 : 0;

            trigger OnValidate()
            var
                Location: Record Location;
            begin
                UpdateAllLocations(Location.FieldNo("Maximum Units"), Location.FieldCaption("Maximum Units"), "Basic Loc. Max. Units", true);
            end;
        }

        field(46; "Adv. Loc. Max. Bots"; Integer)
        {
            Caption = 'Adv - Maximum Bots';
            DataClassification = SystemMetadata;
            BlankZero = true;

            trigger OnValidate()
            var
                Location: Record Location;
            begin
                UpdateAllLocations(Location.FieldNo("Maximum Bots"), Location.FieldCaption("Maximum Bots"), "Adv. Loc. Max. Bots", false);
            end;
        }
        field(47; "Adv. Loc. Max. Units"; Decimal)
        {
            Caption = 'Adv - Maximum Units';
            DataClassification = SystemMetadata;
            BlankZero = true;
            DecimalPlaces = 0 : 0;

            trigger OnValidate()
            var
                Location: Record Location;
            begin
                UpdateAllLocations(Location.FieldNo("Maximum Units"), Location.FieldCaption("Maximum Units"), "Adv. Loc. Max. Units", false);
            end;
        }

        field(50; "Cash Account"; Code[20])
        {
            Caption = 'Cash Account';
            DataClassification = SystemMetadata;
            TableRelation = "G/L Account" where("Direct Posting" = const(true));
        }


        field(60; "Bot Power Account"; Code[20])
        {
            Caption = 'Bot Power Account';
            DataClassification = SystemMetadata;
            TableRelation = "G/L Account" where("Direct Posting" = const(true));
        }
        field(61; "Loc. Power Account"; Code[20])
        {
            Caption = 'Loc. Power Account';
            DataClassification = SystemMetadata;
            TableRelation = "G/L Account" where("Direct Posting" = const(true));
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

    local procedure UpdateAllLocations(WhichFieldNo: Integer; WhichFieldCaption: Text; NewValue: Decimal; Basic: Boolean)
    var
        Location: Record Location;
    begin
        if (Basic) then begin
            if (Confirm(UpdateBasicLocationSettingsQst, true, WhichFieldCaption)) then begin
                Location.SetRange("Require Receive", false);
                UpdateLocations(Location, WhichFieldNo, NewValue);
            end;
        end else begin
            if (Confirm(UpdateAdvLocationSettingsQst, true, WhichFieldCaption)) then begin
                Location.SetRange("Require Receive", true);
                UpdateLocations(Location, WhichFieldNo, NewValue);
            end;
        end;
    end;

    local procedure UpdateLocations(var Location: Record Location; WhichFieldNo: Integer; NewValue: Decimal)
    var
        Player: Record "BCS Player";
    begin
        if Player.FindSet(false) then
            repeat
                case WhichFieldNo of
                    Location.FieldNo("Maximum Units"):
                        begin
                            Location.ChangeCompany(Player."Company Name");
                            if Location.FindSet(true) then
                                repeat
                                    Location."Maximum units" := NewValue;
                                    Location.Modify(false);
                                until Location.Next() = 0;
                        end;
                    Location.FieldNo("Maximum Bots"):
                        begin
                            Location.ChangeCompany(Player."Company Name");
                            if Location.FindSet(true) then
                                repeat
                                    Location."Maximum Bots" := NewValue;
                                    Location.Modify(false);
                                until Location.Next() = 0;
                        end;
                end;
            until Player.Next() = 0;
    end;

    var
        UpdateBasicLocationSettingsQst: Label 'Update %1 in all Basic Locations across Companies?';
        UpdateAdvLocationSettingsQst: Label 'Update %1 in all Advanced Locations across Companies?';

}