page 50071 "MR Header"
{
    ApplicationArea = All;
    Caption = 'MR Header';
    PageType = Document;
    SourceTable = "MR Header";
    PromotedActionCategoriesML = ENU = 'Home,Process,Report,,Request Approve';
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("MR No."; Rec."MR No.")
                {
                    ToolTip = 'Specifies the value of the MR No. field.', Comment = '%';
                }
                field("MR Date"; Rec."MR Date")
                {
                    ToolTip = 'Specifies the value of the MR Date field.', Comment = '%';
                }
                field("Requested By"; Rec."Requested By")
                {
                    ToolTip = 'Specifies the value of the Requested By field.', Comment = '%';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }

            }
            part(MRLine; "MR Line")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "MR No." = field("MR No.");
                UpdatePropagation = Both;
            }
        }
    }
    actions
    {
        area(Navigation)
        {
            group(Action12)
            {
                Caption = 'Release';
                Image = ReOpen;
                action(SubmitMR)
                {
                    ApplicationArea = Suite;
                    Caption = 'Submit MR';
                    Enabled = Rec.Status = Rec.Status::Pending;
                    Image = ReleaseDoc;
                    ShortCutKey = 'Ctrl+F9';
                    Promoted = True;
                    PromotedIsBig = True;
                    PromotedCategory = New;
                    ToolTip = 'Submit the document to the next stage of processing. You must reopen the document before you can make changes to it.';

                    trigger OnAction()
                    begin
                        If UserId <> Rec."Requested By" then
                            Error('Only user %1 is allowed to submit MR', Rec."Requested By");
                        Rec.Status := Rec.Status::Submitted;
                    end;
                }
                action(Reopen)
                {
                    ApplicationArea = Suite;
                    Caption = 'Re&open';
                    Enabled = Rec.Status = Rec.Status::Submitted;
                    Image = ReOpen;
                    Promoted = True;
                    PromotedIsBig = True;
                    PromotedCategory = New;
                    ToolTip = 'Reopen the document to change it after it has been submitted. Submitted documents have the Submitted status and must be opened before they can be changed';
                    trigger OnAction()
                    begin
                        PerformManualReopen();
                    end;
                }
                action(IssueMR)
                {
                    ApplicationArea = Suite;
                    Caption = 'Issue MR';
                    Enabled = Rec.Status = Rec.Status::Submitted;
                    Image = Create;
                    Promoted = True;
                    PromotedIsBig = True;
                    PromotedCategory = New;
                    ToolTip = 'Item Journal Line will be created and the status will change to Issued';
                    trigger OnAction()
                    begin
                        CreateItemJournal();
                        Message('Item Journal Created');

                    end;
                }
                action(PrintMR)
                {
                    ApplicationArea = All;
                    Caption = 'Print MR';
                    Image = Print;
                    ToolTip = 'Prints the Material Requisition report for the current record.';
                    Promoted = True;
                    PromotedIsBig = True;
                    PromotedCategory = New;
                    trigger OnAction()
                    var
                        MRReport: Report "Material Requisition Report";
                        MRRecord: Record "MR Header";
                    begin
                        MRRecord.Copy(rec);
                        MRRecord.SetRange("MR No.", Rec."MR No.");
                        MRReport.SetTableView(MRRecord);
                        MRReport.Run();
                    end;
                }
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        UserSetup: Record "User Setup";
        InventorySetup: Record "Inventory Setup";
        NoSeries: Codeunit "No. Series";
    begin

        InventorySetup.Get();
        If UserSetup.Get(UserId) then;

        Rec."MR No." := NoSeries.PeekNextNo(InventorySetup."MR No.");

        Rec."Requested By" := UserId;
        Rec."Shortcut Dimension 1 Code" := UserSetup."Shortcut Dimension 1 Code";
        Rec."MR Date" := WorkDate();

    end;

    procedure PerformManualReopen()
    begin
        if Rec.Status = Rec.Status::Issued then
            Error(MsgText003);
        if Rec.Status = Rec.Status::Pending then
            exit;
        Rec.Status := Rec.Status::Pending;
    end;

    procedure CreateItemJournal()
    var
        ItemJournalLine: Record "Item Journal Line";
        ItemJournalLineNo: Record "Item Journal Line";
        ItemJL: Record "Item Journal Line";
        MRLine: Record "MR Line";
        ItemJournalBatch: Record "Item Journal Batch";
    begin
        MRLine.Reset();
        MRLine.SetRange("MR No.", Rec."MR No.");
        If MRLine.FindSet() then
            repeat

                //ItemJournalLine."Journal Template Name" := '';
                ItemJournalBatch.Reset();
                ItemJournalBatch.SetRange("MR Batch", True);
                If ItemJournalBatch.FindFirst() then begin
                    ItemJournalLine.Reset();
                    ItemJournalLine.SetRange("Journal Batch Name", ItemJournalBatch.Name);
                    ItemJournalLine.SetRange("Journal Template Name", ItemJournalBatch."Journal Template Name");
                    ItemJournalLine.SetRange("Item No.", '');

                    If not ItemJournalLine.FindFirst() then begin
                        ItemJournalLine.SetFilter("Item No.", '<>%1', '');
                        ItemJournalLine.SetRange("Document No.", MRLine."MR No.");
                        ItemJournalLine.SetRange("Document Line No.", MRLine."Line No.");
                        If not ItemJournalLine.FindFirst() then begin
                            ItemJournalLine.Init();
                            ItemJournalLine.Validate("Journal Template Name", ItemJournalBatch."Journal Template Name");
                            ItemJournalLine.Validate("Journal Batch Name", ItemJournalBatch.Name);
                            ItemJournalLineNo.Reset();
                            ItemJournalLineNo.SetAscending("Line No.", false);
                            ItemJournalLineNo.SetRange("Journal Batch Name", ItemJournalBatch.Name);
                            ItemJournalLineNo.SetRange("Journal Template Name", ItemJournalBatch."Journal Template Name");
                            If ItemJournalLineNo.FindFirst() then
                                ItemJournalLine."Line No." := ItemJournalLineNo."Line No." + 10000
                            else
                                ItemJournalLine."Line No." := 10000;
                            ItemJournalLine.Insert(True);
                        end;
                    end;
                end
                else
                    Error('Item Journal batch not selected');


                ItemJournalLine.Validate("Item No.", MRLine."Item No.");
                ItemJournalLine.Validate("Posting Date", WorkDate());
                ItemJournalLine.Validate("Entry Type", ItemJournalLine."Entry Type"::"Negative Adjmt.");
                ItemJournalLine.Validate("Document No.", MRLine."MR No.");
                ItemJournalLine."Document Line No." := MRLine."Line No.";
                ItemJournalLine.Validate("Location Code", MRLine."Issuing Location");
                ItemJournalLine.Validate(Quantity, MRLine.Quantity);

                ItemJournalLine.Modify();
            until MRLine.Next() = 0;
    end;

    var
        MsgText003: Label 'Cannot change the values with status Issued';

}
