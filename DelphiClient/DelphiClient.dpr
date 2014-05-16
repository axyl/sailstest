program DelphiClient;

uses
  Vcl.Forms,
  Main in 'Main.pas' {MainForm},
  ScanItem_FindBox in 'ScanItem_FindBox.pas' {ScanItem_FindBoxForm},
  ScanItem_NewBox in 'ScanItem_NewBox.pas' {ScanItem_NewBoxForm},
  superobject in 'ExternalUnits\superobjectv1.2.4\superobject.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TScanItem_FindBoxForm, ScanItem_FindBoxForm);
  Application.CreateForm(TScanItem_NewBoxForm, ScanItem_NewBoxForm);
  Application.Run;
end.
