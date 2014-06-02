unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Base;

type
  TMainForm = class(TbaseForm)
    ScanItemsBtn: TButton;
    PackerName: TLabeledEdit;
    ManageLocationsBtn: TButton;
    PackBoxBtn: TButton;
    serverNameEdt: TLabeledEdit;
    btnGetBoxCSVFile: TButton;
    procedure ScanItemsBtnClick(Sender: TObject);
    procedure ManageLocationsBtnClick(Sender: TObject);
    procedure PackBoxBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure serverNameEdtChange(Sender: TObject);
    procedure btnGetBoxCSVFileClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses ScanItem_FindBox, Location_Main, Box_Move, System.IniFiles, DataModule, WinAPI.ShellAPI;

procedure TMainForm.PackBoxBtnClick(Sender: TObject);
begin
  inherited;
  Box_MoveForm.ShowModal;
end;

procedure TMainForm.ScanItemsBtnClick(Sender: TObject);
begin
  ScanItem_FindBoxForm.ShowModal;
end;

procedure TMainForm.serverNameEdtChange(Sender: TObject);
begin
  inherited;
  // TODO : Currently running every single time a text change is made...but meh.
  if Assigned(DataModule1) and assigned(DataModule1.restClient1) then
    DataModule1.restClient1.BaseURL:= serverNameEdt.Text;

end;

procedure TMainForm.btnGetBoxCSVFileClick(Sender: TObject);
begin
  inherited;
  ShellExecute(0, 'OPEN', pChar(DataModule1.restClient1.BaseURL+ '/box/list'), '', '', SW_SHOWNORMAL);
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
var
  iniSettings: TIniFile;
begin
  inherited;
  iniSettings:= TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
  try
    iniSettings.WriteString('server', 'serverURL', serverNameEdt.text);
    iniSettings.WriteString('user', 'packerName', packerName.Text);
  finally
    freeandNil(iniSettings);
  end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  iniSettings: TIniFile;
begin
  inherited;
  iniSettings:= TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
  try
    if iniSettings.ValueExists('server', 'serverURL') then
      serverNameEdt.Text:= iniSettings.ReadString('server','serverURL', serverNameEdt.Text)
    else
      iniSettings.WriteString('server', 'serverURL', serverNameEdt.text);
    if iniSettings.ValueExists('user','packerName') then
      packerName.Text:= iniSettings.ReadString('user', 'packerName', packerName.Text)
    else
      iniSettings.WriteString('user', 'packerName', packerName.Text);
  finally
    freeandNil(iniSettings);
  end;
end;

procedure TMainForm.ManageLocationsBtnClick(Sender: TObject);
begin
  inherited;
  Location_MainForm.ShowModal;
end;

end.
