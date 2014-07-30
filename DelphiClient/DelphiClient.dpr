program DelphiClient;

uses
  Vcl.Forms,
  Main in 'Main.pas' {MainForm},
  ScanItem_FindBox in 'ScanItem_FindBox.pas' {ScanItem_FindBoxForm},
  ScanItem_NewBox in 'ScanItem_NewBox.pas' {ScanItem_NewBoxForm},
  superobject in 'ExternalUnits\superobjectv1.2.4\superobject.pas',
  Base in 'Base.pas' {baseForm},
  Location_Main in 'Location_Main.pas' {Location_MainForm},
  DataModule in 'DataModule.pas' {DataModule1: TDataModule},
  Location_AddEdit in 'Location_AddEdit.pas' {Location_AddEditForm},
  Box_Move in 'Box_Move.pas' {Box_MoveForm},
  Box_FindBox in 'Box_FindBox.pas' {Box_FindBoxForm},
  ScanItem_DeleteFromBox in 'ScanItem_DeleteFromBox.pas' {ScanItem_DeleteFromBoxForm},
  ScanItem_AddToBox in 'ScanItem_AddToBox.pas' {ScanItem_AddToBoxForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TScanItem_FindBoxForm, ScanItem_FindBoxForm);
  Application.CreateForm(TScanItem_NewBoxForm, ScanItem_NewBoxForm);
  Application.CreateForm(TbaseForm, baseForm);
  Application.CreateForm(TLocation_MainForm, Location_MainForm);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TLocation_AddEditForm, Location_AddEditForm);
  Application.CreateForm(TBox_MoveForm, Box_MoveForm);
  Application.CreateForm(TBox_FindBoxForm, Box_FindBoxForm);
  Application.CreateForm(TScanItem_DeleteFromBoxForm, ScanItem_DeleteFromBoxForm);
  Application.CreateForm(TScanItem_AddToBoxForm, ScanItem_AddToBoxForm);
  Application.Run;
end.
