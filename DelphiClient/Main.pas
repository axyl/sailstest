unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Base,
  Data.Bind.Components, Data.Bind.ObjectScope, REST.Client;

type
  TMainForm = class(TbaseForm)
    ScanItemsBtn: TButton;
    PackerName: TLabeledEdit;
    ManageLocationsBtn: TButton;
    PackBoxBtn: TButton;
    serverNameEdt: TLabeledEdit;
    btnGetBoxCSVFile: TButton;
    SearchBoxesBtn: TButton;
    DeleteItemBtn: TButton;
    Label1: TLabel;
    cmbCurrentSortingJob: TComboBox;
    getSortingJobs: TRESTRequest;
    procedure ScanItemsBtnClick(Sender: TObject);
    procedure ManageLocationsBtnClick(Sender: TObject);
    procedure PackBoxBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure serverNameEdtChange(Sender: TObject);
    procedure btnGetBoxCSVFileClick(Sender: TObject);
    procedure SearchBoxesBtnClick(Sender: TObject);
    procedure DeleteItemBtnClick(Sender: TObject);
    procedure cmbCurrentSortingJobDropDown(Sender: TObject);
    procedure cmbCurrentSortingJobSelect(Sender: TObject);
  private
    function sortingJobSet: Boolean;
    { Private declarations }
  public
    { Public declarations }
    currentSortingJobID: Integer;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses ScanItem_FindBox, Location_Main, Box_Move, System.IniFiles, DataModule, WinAPI.ShellAPI,
  Box_FindBox, ScanItem_DeleteFromBox, SuperObject;

function TMainForm.sortingJobSet: Boolean;
begin
  result:= false;
  if currentSortingJobID> 0 then
    Result:= true
  else
  begin
    if length(cmbCurrentSortingJob.text)> 0 then
    begin
      currentSortingJobID:= DataModule1.findJobsSortID(cmbCurrentSortingJob.text);
      if currentSortingJobID> 0 then
        result:= true;
    end
    else
      MessageDlg('Please select a Sorting Job first.', mtError, [mbOK], 0);
  end;
end;

procedure TMainForm.PackBoxBtnClick(Sender: TObject);
begin
  inherited;
  Box_MoveForm.ShowModal;
end;

procedure TMainForm.ScanItemsBtnClick(Sender: TObject);
begin
  if sortingJobSet then
    ScanItem_FindBoxForm.ShowModal;
end;

procedure TMainForm.SearchBoxesBtnClick(Sender: TObject);
begin
  inherited;
  Box_FindBoxForm.ShowModal;
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
  if sortingJobSet then
    ShellExecute(0, 'OPEN', pChar(DataModule1.restClient1.BaseURL+ '/box/list?sortJob='+ InttoStr(self.currentSortingJobID)), '', '', SW_SHOWNORMAL);
end;

procedure TMainForm.cmbCurrentSortingJobDropDown(Sender: TObject);
var
  jsonResponse: ISuperObject;
  loopJobs: Integer;
begin
  inherited;
  cmbCurrentSortingJob.Items.Clear;
  // Need to load the list of available Sorting Jobs.
  if DataModule1.ExecuteRest(getSortingJobs, 'Requesting Sort Jobs.') then
  begin
    jsonResponse:= SO(getSortingJobs.Response.Content);

    for loopJobs := 0 to jsonResponse.AsArray.Length- 1 do
    begin
      cmbCurrentSortingJob.Items.Add(jsonResponse.AsArray[loopJobs].S['name']);
    end;
  end;
end;

procedure TMainForm.cmbCurrentSortingJobSelect(Sender: TObject);
begin
  inherited;
  currentSortingJobID:= DataModule1.findJobsSortID(cmbCurrentSortingJob.text);
end;

procedure TMainForm.DeleteItemBtnClick(Sender: TObject);
begin
  inherited;
  ScanItem_DeleteFromBoxForm.ShowModal;
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
    if (currentSortingJobID> -1) and (cmbCurrentSortingJob.Text<> '') then
      iniSettings.WriteString('user', 'currentSortJob', cmbCurrentSortingJob.text);
  finally
    freeandNil(iniSettings);
  end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  iniSettings: TIniFile;
begin
  inherited;
  currentSortingJobID:= -1;
  cmbCurrentSortingJob.Text:= '';

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
    if iniSettings.ValueExists('user', 'currentSortJob') then
      cmbCurrentSortingJob.Text:= iniSettings.readString('user', 'currentSortJob', '');
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
