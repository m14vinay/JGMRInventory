page 50077 "O365 for Sales"
{
    Caption = 'O365 for Sales';
    PageType = CardPart;
    RefreshOnActivate = true;
    ShowFilter = false;
    SourceTable = "Activities Cue";

    layout
    {
        area(content)
        {
            cuegroup(Control54)
            {
                CueGroupLayout = Wide;
                ShowCaption = false;
                field("Sales This Month"; Rec."Sales This Month")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageID = "Sales Invoice List";
                    ToolTip = 'Specifies the sum of sales in the current month excluding taxes.';

                    trigger OnDrillDown()
                    begin
                        ActivitiesMgt.DrillDownSalesThisMonth();
                    end;
                }
                field("Overdue Sales Invoice Amount"; Rec."Overdue Sales Invoice Amount")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the sum of overdue payments from customers.';

                    trigger OnDrillDown()
                    begin
                        ActivitiesMgt.DrillDownCalcOverdueSalesInvoiceAmount();
                    end;
                }
            }
            cuegroup(Welcome)
            {
                Caption = 'Welcome';
                Visible = TileGettingStartedVisible;

                actions
                {
                    action(GettingStartedTile)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Return to Getting Started';
                        Image = TileVideo;
                        ToolTip = 'Learn how to get started with Dynamics 365.';

                        trigger OnAction()
                        begin
                            O365GettingStartedMgt.LaunchWizard(true, false);
                        end;
                    }
                }
            }
            cuegroup("Ongoing Sales")
            {
                Caption = 'Ongoing Sales';

                field("Ongoing Sales Orders"; Rec."Ongoing Sales Orders")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Orders';
                    DrillDownPageID = "Sales Order List";
                    ToolTip = 'Specifies sales orders that are not yet posted or only partially posted.';
                }
                field("Ongoing Sales Invoices"; Rec."Ongoing Sales Invoices")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Invoices';
                    DrillDownPageID = "Sales Invoice List";
                    ToolTip = 'Specifies sales invoices that are not yet posted or only partially posted.';
                }
            }
            cuegroup("Data Integration")
            {
                Caption = 'Data Integration';
                Visible = ShowDataIntegrationCues;
                field("CDS Integration Errors"; Rec."CDS Integration Errors")
                {
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Integration Errors';
                    DrillDownPageID = "Integration Synch. Error List";
                    ToolTip = 'Specifies the number of errors related to data integration.';
                    Visible = ShowIntegrationErrorsCue;
                    StyleExpr = IntegrationErrorsCue;
                }
                field("Coupled Data Synch Errors"; Rec."Coupled Data Synch Errors")
                {
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Coupled Data Synchronization Errors';
                    DrillDownPageID = "CRM Skipped Records";
                    ToolTip = 'Specifies the number of errors that occurred in the latest synchronization of coupled data between Business Central and Dynamics 365 Sales.';
                    Visible = ShowD365SIntegrationCues;
                    StyleExpr = CoupledErrorsCue;
                }
            }
            cuegroup("Get started")
            {
                Caption = 'Get started';
                Visible = ReplayGettingStartedVisible;
                actions
                {
                    action(ReplayGettingStarted)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Replay Getting Started';
                        Image = TileVideo;
                        ToolTip = 'Show the Getting Started guide again.';
                        trigger OnAction()
                        var
                            O365GettingStarted: Record "O365 Getting Started";
                        begin
                            if O365GettingStarted.Get(UserId, ClientTypeManagement.GetCurrentClientType()) then begin
                                O365GettingStarted."Tour in Progress" := false;
                                O365GettingStarted."Current Page" := 1;
                                O365GettingStarted.Modify();
                                Commit();
                            end;
                            O365GettingStartedMgt.LaunchWizard(true, false);
                        end;
                    }
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(RefreshData)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Refresh Data';
                Image = Refresh;
                ToolTip = 'Refreshes the data needed to make complex calculations.';

                trigger OnAction()
                begin
                    Rec."Last Date/Time Modified" := 0DT;
                    Rec.Modify();

                    CODEUNIT.Run(CODEUNIT::"Activities Mgt.");
                    CurrPage.Update(false);
                end;
            }
            action("Set Up Cues")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Set Up Cues';
                Image = Setup;
                ToolTip = 'Set up the cues (status tiles) related to the role.';

                trigger OnAction()
                var
                    CueRecordRef: RecordRef;
                begin
                    CueRecordRef.GetTable(Rec);
                    CuesAndKpis.OpenCustomizePageForCurrentUser(CueRecordRef.Number);
                end;
            }
        }
    }

   

    trigger OnAfterGetRecord()
    begin
        SetActivityGroupVisibility();
    end;

    trigger OnInit()
    begin
        if O365GettingStartedMgt.AreUserToursEnabled() then
            O365GettingStartedMgt.UpdateGettingStartedVisible(TileGettingStartedVisible, ReplayGettingStartedVisible);
    end;

    trigger OnOpenPage()
    var
        IntegrationSynchJobErrors: Record "Integration Synch. Job Errors";
        CRMIntegrationRecord: Record "CRM Integration Record";
        OCRServiceMgt: Codeunit "OCR Service Mgt.";
        RoleCenterNotificationMgt: Codeunit "Role Center Notification Mgt.";
        ConfPersonalizationMgt: Codeunit "Conf./Personalization Mgt.";
        CDSIntegrationMgt: Codeunit "CDS Integration Mgt.";
        CRMIntegrationManagement: Codeunit "CRM Integration Management";
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
            Commit();
        end;

        Rec.SetFilter("Due Next Week Filter", '%1..%2', CalcDate('<1D>', WorkDate()), CalcDate('<1W>', WorkDate()));

        HasCamera := Camera.IsAvailable();

       // PrepareOnLoadDialog();

        ShowAwaitingIncomingDoc := OCRServiceMgt.OcrServiceIsEnable();
        ShowIntercompanyActivities := false;
        ShowDocumentsPendingDocExchService := false;
        IntegrationSynchJobErrors.SetDataIntegrationUIElementsVisible(ShowDataIntegrationCues);
        //tShowD365SIntegrationCues := CRMIntegrationManagement.IsIntegrationEnabled() or CDSIntegrationMgt.IsIntegrationEnabled();
        ShowIntegrationErrorsCue := ShowDataIntegrationCues and (not ShowD365SIntegrationCues);

        if IntegrationSynchJobErrors.IsEmpty() then
            IntegrationErrorsCue := 'Favorable'
        else
            IntegrationErrorsCue := 'Unfavorable';
        CRMIntegrationRecord.SetRange(Skipped, true);
        if CRMIntegrationRecord.IsEmpty() then
            CoupledErrorsCue := 'Favorable'
        else
            CoupledErrorsCue := 'Unfavorable';

        RoleCenterNotificationMgt.ShowNotifications();
        ConfPersonalizationMgt.RaiseOnOpenRoleCenterEvent();

        CalculateCueFieldValues();
    end;

    var
        ActivitiesMgt: Codeunit "Activities Mgt.";
        CuesAndKpis: Codeunit "Cues And KPIs";
        O365GettingStartedMgt: Codeunit "O365 Getting Started Mgt.";
        ClientTypeManagement: Codeunit "Client Type Management";
        Camera: Codeunit Camera;
       
        HasCamera: Boolean;
        ShowDocumentsPendingDocExchService: Boolean;
        ShowAwaitingIncomingDoc: Boolean;
        ShowIntercompanyActivities: Boolean;
        TileGettingStartedVisible: Boolean;
        ReplayGettingStartedVisible: Boolean;
        HideSatisfactionSurvey: Boolean;
        WhatIsNewTourVisible: Boolean;
        ShowD365SIntegrationCues: Boolean;
        ShowDataIntegrationCues: Boolean;
        ShowIntegrationErrorsCue: Boolean;
        HideWizardForDevices: Boolean;
        IsAddInReady: Boolean;
        IsPageReady: Boolean;
        RecordForUpdateCachedCueValuesIsLocked: Boolean;
        TaskIdCalculateCue: Integer;
        IntegrationErrorsCue: Text;
        CoupledErrorsCue: Text;
        PBTList: Dictionary of [Integer, Text];
        CachedCueValuesCalculationStartDateTime: DateTime;
        PBTTelemetryCategoryLbl: Label 'PBT', Locked = true;
        PBTTelemetryMsgTxt: Label 'PBT errored with code %1 and text %2. The call stack is as follows %3.', Locked = true;

    procedure CalculateCueFieldValues()
    begin
        ClearExistingPageBackgroundTasks();
        CalculateNonCachedCueFieldValues();
        CalculateCachedCueFieldValues();
    end;

    local procedure ClearExistingPageBackgroundTasks()
    var
        TaskId: Integer;
    begin
        if PBTList.Count() > 0 then
            foreach TaskId in PBTList.Keys() do begin
                CurrPage.CancelBackgroundTask(TaskId);
                PBTList.Remove(TaskId);
            end;
    end;

    local procedure CalculateNonCachedCueFieldValues()
    begin
        SchedulePBT(Rec.FieldName("Sales This Month"), Rec.FieldCaption("Sales This Month"));
    end;

    local procedure CalculateCachedCueFieldValues()
    begin
        CachedCueValuesCalculationStartDateTime := CurrentDateTime();
        /*if not ActivitiesMgt.IsCachedCueDataExpired(Rec, CachedCueValuesCalculationStartDateTime) then begin
            Clear(CachedCueValuesCalculationStartDateTime);
            exit;
        end;*/

        SchedulePBT(Rec.FieldName("Overdue Sales Invoice Amount"), Rec.FieldCaption("Overdue Sales Invoice Amount"));
        SchedulePBT(Rec.FieldName("Overdue Purch. Invoice Amount"), Rec.FieldCaption("Overdue Purch. Invoice Amount"));
        SchedulePBT(Rec.FieldName("Average Collection Days"), Rec.FieldCaption("Average Collection Days"));
        SchedulePBT(Rec.FieldName("S. Ord. - Reserved From Stock"), Rec.FieldCaption("S. Ord. - Reserved From Stock"));
    end;

    trigger OnPageBackgroundTaskError(TaskId: Integer; ErrorCode: Text; ErrorText: Text; ErrorCallStack: Text; var IsHandled: Boolean)
    var
        ScheduledTask: Record "Scheduled Task";
    begin
        Session.LogMessage('00009V0', StrSubstNo(PBTTelemetryMsgTxt, ErrorCode, ErrorText, ErrorCallStack), Verbosity::Warning, DataClassification::CustomerContent, TelemetryScope::ExtensionPublisher, 'Category', PBTTelemetryCategoryLbl);

        if not PBTList.ContainsKey(TaskId) then
            exit;

       /* if ActivitiesMgt.IsCueDataStale() then
            if not TASKSCHEDULER.CanCreateTask() then
                CODEUNIT.Run(CODEUNIT::"Activities Mgt.")
            else begin
                ScheduledTask.SetRange("Run Codeunit", CODEUNIT::"Activities Mgt.");
                ScheduledTask.SetRange(Company, CompanyName);
                ScheduledTask.SetRange("Is Ready", true);
                if ScheduledTask.IsEmpty() then
                    TASKSCHEDULER.CreateTask(CODEUNIT::"Activities Mgt.", 0, true, CompanyName, CurrentDateTime);
            end;*/

        IsHandled := true;
    end;

    trigger OnPageBackgroundTaskCompleted(TaskId: Integer; Results: Dictionary of [Text, Text])
    var
        O365ActivitiesDictionary: Codeunit "O365 Activities Dictionary";
    begin
        // As PBT runs synchronously when running in test, the task is called even before PBTList is updated.
        // So, we use (TaskIdCalculateCue = TaskId) to check if the task is the one we are interested in.
        if PBTList.ContainsKey(TaskId) then begin
            if not RecordForUpdateCachedCueValuesIsLocked then begin
                Rec.LockTable(true);
                Rec.Get();
                RecordForUpdateCachedCueValuesIsLocked := true;
            end;
            O365ActivitiesDictionary.FillActivitiesCue(Results, Rec);
            if PBTList.ContainsKey(TaskId) then begin
                PBTList.Remove(TaskId);
                if PBTList.Count() = 0 then begin
                    RecordForUpdateCachedCueValuesIsLocked := false;
                    if CachedCueValuesCalculationStartDateTime <> 0DT then
                        Rec."Last Date/Time Modified" := CachedCueValuesCalculationStartDateTime;
                    Rec.Modify(true);
                    Commit();
                end;
            end;
            exit;
        end;

        // If task is finished before PBTList is updated.
        if TaskIdCalculateCue = TaskId then begin
            Rec.LockTable(true);
            Rec.Get();
            O365ActivitiesDictionary.FillActivitiesCue(Results, Rec);
            // Set new date/time if this is the last PBT task.
            if Results.ContainsKey(Rec.FieldName("S. Ord. - Reserved From Stock")) then
                Rec."Last Date/Time Modified" := CachedCueValuesCalculationStartDateTime;
            Rec.Modify(true);
            Commit();
            TaskIdCalculateCue := 0;
        end;
    end;

    local procedure SchedulePBT(FieldName: Text; FieldCaption: Text)
    var
        Input: Dictionary of [Text, Text];
        TimeoutinMs: Integer;
    begin
        TimeoutinMs := 2000; // Default timeout;
        OnGetBackgroundTaskTimeout(TimeoutInMs);
        Clear(Input);
        Input.Add(FieldName, '');
        CurrPage.EnqueueBackgroundTask(TaskIdCalculateCue, Codeunit::"O365 Activities Dictionary", Input, TimeoutInMs);
        if TaskIdCalculateCue <> 0 then
            PBTList.Add(TaskIdCalculateCue, FieldCaption);
    end;

    local procedure SetActivityGroupVisibility()
    var
        DocExchServiceSetup: Record "Doc. Exch. Service Setup";
        ICSetup: Record "IC Setup";
    begin
        DocExchServiceSetup.SetLoadFields("Enabled");
        if DocExchServiceSetup.Get() then
            ShowDocumentsPendingDocExchService := DocExchServiceSetup.Enabled;

        ICSetup.SetLoadFields("IC Partner Code");
        if ICSetup.Get() then
            ShowIntercompanyActivities :=
              (ICSetup."IC Partner Code" <> '') and ((Rec."IC Inbox Transactions" <> 0) or (Rec."IC Outbox Transactions" <> 0));
    end;

    local procedure StartWhatIsNewTour(hasTourCompleted: Boolean): Boolean
    var
        O365UserTours: Record "User Tours";
        TourID: Integer;
    begin
        TourID := O365GettingStartedMgt.GetWhatIsNewTourID();

        if O365UserTours.AlreadyCompleted(TourID) then
            exit(false);

        if not hasTourCompleted then begin
           // UserTours.StartUserTour(TourID);
            WhatIsNewTourVisible := true;
            exit(true);
        end;

        if WhatIsNewTourVisible then begin
            O365UserTours.MarkAsCompleted(TourID);
            WhatIsNewTourVisible := false;
        end;
        exit(false);
    end;

   

   
    [IntegrationEvent(false, false)]
    local procedure OnGetBackgroundTaskTimeout(var TimeoutInMs: Integer)
    begin
    end;
}


