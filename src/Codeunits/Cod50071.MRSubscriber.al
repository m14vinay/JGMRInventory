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
  
    begin
      TransferShipmentHeader."Vehicle No" := TransferHeader."Vehicle No";
      TransferShipmentHeader."Driver Name" := TransferHeader."Driver Name";
      TransferShipmentHeader.Modify();
    end;
}
