codeunit 50071 "MR Subscriber"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Batch", 'OnAfterPostLines', '', false, false)]
    local procedure OnBeforePostWhseRcptHeader(var ItemJournalLine: Record "Item Journal Line"; var ItemRegNo: Integer; var WhseRegNo: Integer)
    var
    MRHeader: Record "MR Header";
    begin
      If ItemJournalLine.FindSet() then repeat
      MRHeader.Reset();
      MRHeader.SetRange("MR No.",ItemJournalLine."Document No."); 
      If MRHeader.FindFirst() then begin
        MRHeader.Status := MRHeader.Status::Issued;
        MRHeader.Modify();
      end;
      until ItemJournalLine.Next() = 0
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", 'OnRunOnBeforeCommit', '', false, false)]
    local procedure OnRunOnBeforeCommit(var TransHeader: Record "Transfer Header"; var TransRcptHeader: Record "Transfer Receipt Header"; PostedWhseRcptHeader: Record "Posted Whse. Receipt Header"; var SuppressCommit: Boolean)
  
    begin
      TransRcptHeader."Vehicle No" := TransHeader."Vehicle No";
      TransRcptHeader."Driver Name" := TransHeader."Driver Name";
      TransRcptHeader.Modify();
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", 'OnRunOnBeforeCommit', '', false, false)]
    local procedure UpdateVehicleNo(var TransferHeader: Record "Transfer Header"; var TransferShipmentHeader: Record "Transfer Shipment Header"; PostedWhseShptHeader: Record "Posted Whse. Shipment Header"; var SuppressCommit: Boolean)
    var
    TransferLine : Record "Transfer Line";
    TransferShipmentLine : Record "Transfer Shipment Line";
    begin
      TransferShipmentHeader.Supplier := TransferHeader.Supplier;
      TransferShipmentHeader."Vehicle No" := TransferHeader."Vehicle No";
      TransferShipmentHeader."Driver Name" := TransferHeader."Driver Name";
      TransferShipmentHeader.Modify();
     
    end;
    [EventSubscriber(ObjectType::Table, Database::"Transfer Shipment Line", 'OnAfterCopyFromTransferLine', '', false, false)]
    local procedure OnAfterCopyFromTransferLine(var TransferShipmentLine: Record "Transfer Shipment Line"; TransferLine: Record "Transfer Line")
    var
        Item: Record Item;
        PackSize: Record "Pack Size";
    begin
        If Item.Get(TransferLine."Item No.") then
            If PackSize.Get(Item."Pack Size") then
                TransferShipmentLine."Quantity Pieces" := TransferLine."Qty. to Ship" * PackSize."Qty Per Pack";
                TransferShipmentLine.Returnable := TransferLine.Returnable;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Transfer Receipt Line", 'OnAfterCopyFromTransferLine', '', false, false)]
    local procedure OnAfterCopyFromTransferLineRecpt(var TransferReceiptLine: Record "Transfer Receipt Line"; TransferLine: Record "Transfer Line")
    var
        Item: Record Item;
        PackSize: Record "Pack Size";
    begin
        If Item.Get(TransferLine."Item No.") then
            If PackSize.Get(Item."Pack Size") then
                TransferReceiptLine."Quantity Pieces" := TransferLine."Qty. to Receive" * PackSize."Qty Per Pack";
    end;
     [EventSubscriber(ObjectType::Codeunit, CodeUnit::"TransferOrder-Post Shipment", 'OnAfterCreateItemJnlLine', '', false, false)]
    local procedure OnAfterCreateItemJnlLine(var ItemJournalLine: Record "Item Journal Line"; TransferLine: Record "Transfer Line"; TransferShipmentHeader: Record "Transfer Shipment Header"; TransferShipmentLine: Record "Transfer Shipment Line")
    var
        Item: Record Item;
        PackSize: Record "Pack Size";
    begin
        If Item.Get(TransferLine."Item No.") then
            If PackSize.Get(Item."Pack Size") then
                ItemJournalLine."Quantity Pieces" := TransferLine."Qty. to Ship" * PackSize."Qty Per Pack";
    end;

    [EventSubscriber(ObjectType::Codeunit, CodeUnit::"TransferOrder-Post Receipt", 'OnBeforePostItemJournalLine', '', false, false)]
    local procedure OnBeforePostItemJournalLine(var ItemJournalLine: Record "Item Journal Line"; TransferLine: Record "Transfer Line"; TransferReceiptHeader: Record "Transfer Receipt Header"; TransferReceiptLine: Record "Transfer Receipt Line"; CommitIsSuppressed: Boolean; TransLine: Record "Transfer Line"; PostedWhseRcptHeader: Record "Posted Whse. Receipt Header")
    var
        Item: Record Item;
        PackSize: Record "Pack Size";
    begin
        If Item.Get(TransferLine."Item No.") then
            If PackSize.Get(Item."Pack Size") then
                ItemJournalLine."Quantity Pieces" := TransferLine."Qty. to Receive" * PackSize."Qty Per Pack";
    end;

    [EventSubscriber(ObjectType::Codeunit, CodeUnit::"TransferOrder-Post Transfer", 'OnAfterCreateItemJnlLine', '', false, false)]
    local procedure OnAfterCreateItemJnlLineTransfer(var ItemJnlLine: Record "Item Journal Line"; TransLine: Record "Transfer Line"; DirectTransHeader: Record "Direct Trans. Header"; DirectTransLine: Record "Direct Trans. Line")

    begin
        ItemJnlLine."Quantity Pieces" := TransLine."Quantity Pieces";
    end;
}
