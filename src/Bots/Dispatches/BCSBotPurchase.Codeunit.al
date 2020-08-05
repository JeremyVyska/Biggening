codeunit 88006 "BCS Bot Purchase"
{
    TableNo = "BCS Bot Instance";

    trigger OnRun()
    var
        Documents: List of [Code[20]];
        DocListBuilder: TextBuilder;
        DocNo: Text;
        i: Integer;
    begin
        //Error('Hello Stream!');
        //ResultText := StrSubstNo('In the future, I would make %1 purchases.', Rec."Operations Per Day");

        for i := 1 to Rec."Operations Per Day" do begin
            // If the Purchasing Bot is assigned:
            if Rec."Assignment Code" <> '' then
                Documents.Add(CreatePO(Rec."Assignment Code"))
            else
                // Else, they will 'farm' for new suppliers
                Error('farming not yet supported');
        end;

        if Rec."Assignment Code" <> '' then begin
            foreach DocNo in Documents do
                DocListBuilder.Append(DocNo + ', ');
            DocListBuilder.Remove(DocListBuilder.Length - 2, 2);
            Commit();
            foreach DocNo in Documents do begin
                PostPO(DocNo);
                Commit();
            end;
            ResultText := StrSubstNo('%1: %2', Documents.Count, DocListBuilder.ToText());
        end;
    end;

    procedure GetResultText(): Text[200]
    begin
        exit(ResultText);
    end;


    /*
 
  .d8888b.                           888                 8888888b.   .d88888b.  
 d88P  Y88b                          888                 888   Y88b d88P" "Y88b 
 888    888                          888                 888    888 888     888 
 888        888d888 .d88b.   8888b.  888888 .d88b.       888   d88P 888     888 
 888        888P"  d8P  Y8b     "88b 888   d8P  Y8b      8888888P"  888     888 
 888    888 888    88888888 .d888888 888   88888888      888        888     888 
 Y88b  d88P 888    Y8b.     888  888 Y88b. Y8b.          888        Y88b. .d88P 
  "Y8888P"  888     "Y8888  "Y888888  "Y888 "Y8888       888         "Y88888P"  
 
*/

    local procedure CreatePO(VendorNo: Code[20]): Code[20]
    var
        PurchaseHeader: Record "Purchase Header";
    begin
        // Count of BOTH The open PO docs, and the posted docs

        PurchaseHeader.Validate("Document Type", PurchaseHeader."Document Type"::Order);
        PurchaseHeader.Validate("Buy-from Vendor No.", VendorNo);
        PurchaseHeader.Insert(true);

        //Testing, just one
        CreateLine(PurchaseHeader);

        exit(PurchaseHeader."No.");
    end;

    /*
 
  .d8888b.                           888                 888      d8b                   
 d88P  Y88b                          888                 888      Y8P                   
 888    888                          888                 888                            
 888        888d888 .d88b.   8888b.  888888 .d88b.       888      888 88888b.   .d88b.  
 888        888P"  d8P  Y8b     "88b 888   d8P  Y8b      888      888 888 "88b d8P  Y8b 
 888    888 888    88888888 .d888888 888   88888888      888      888 888  888 88888888 
 Y88b  d88P 888    Y8b.     888  888 Y88b. Y8b.          888      888 888  888 Y8b.     
  "Y8888P"  888     "Y8888  "Y888888  "Y888 "Y8888       88888888 888 888  888  "Y8888  
 
*/

    local procedure CreateLine(var PurchaseHeader: Record "Purchase Header")
    var
        PurchaseLine: Record "Purchase Line";
        NextLineNo: Integer;
    begin
        //Later, NextLineNo ?
        NextLineNo := 10000;

        PurchaseLine.Validate("Document Type", PurchaseHeader."Document Type");
        PurchaseLine.Validate("Document No.", PurchaseHeader."No.");
        PurchaseLine.Validate("Line No.", NextLineNo);
        PurchaseLine.Insert(true);
        PurchaseLine.Validate(Type, PurchaseLine.Type::Item);
        PurchaseLine.Validate("No.", '1000');
        PurchaseLine.Validate(Quantity, Random(10) + 10);
        PurchaseLine.validate("Direct Unit Cost", Random(10) + 10);
        PurchaseLine.Modify(true);
    end;

    /*

8888888b.                   888         8888888b.   .d88888b.  
888   Y88b                  888         888   Y88b d88P" "Y88b 
888    888                  888         888    888 888     888 
888   d88P .d88b.  .d8888b  888888      888   d88P 888     888 
8888888P" d88""88b 88K      888         8888888P"  888     888 
888       888  888 "Y8888b. 888         888        888     888 
888       Y88..88P      X88 Y88b.       888        Y88b. .d88P 
888        "Y88P"   88888P'  "Y888      888         "Y88888P"  

*/

    local procedure PostPO(PurchaseOrderNo: Code[20])
    var
        PurchaseHeader: Record "Purchase Header";
        PurchPost: Codeunit "Purch.-Post";
    begin
        if PurchaseHeader.Get(PurchaseHeader."Document Type"::Order, PurchaseOrderNo) then begin
            PurchaseHeader.Receive := true;
            PurchaseHeader.Invoice := true;
            PurchPost.SetPostingFlags(PurchaseHeader);
            PurchPost.Run(PurchaseHeader);
        end;
    end;

    var
        ResultText: Text[200];
}
