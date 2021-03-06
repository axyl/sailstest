unit ScanItem_NewBox;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SuperObject, IPPeerClient, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TScanItem_NewBoxForm = class(TForm)
    BoxSKUEdt: TLabeledEdit;
    BoxLocationEdt: TLabeledEdit;
    boxGroupEdt: TLabeledEdit;
    SetupBoxBtn: TButton;
    createBoxRes: TRESTRequest;
    findLocationID: TRESTRequest;
    procedure SetupBoxBtnClick(Sender: TObject);
    procedure BoxSKUEdtKeyPress(Sender: TObject; var Key: Char);
    procedure BoxLocationEdtKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    boxGroupID: String;

  public
    { Public declarations }
    newBoxID: Integer;
    function SetupNewBox(lastItemResp: ISuperObject): Boolean; overload;
    function SetupNewBox(boxGroupID: string): Boolean; overload;
  end;

var
  ScanItem_NewBoxForm: TScanItem_NewBoxForm;

implementation

{$R *.dfm}

uses DataModule, Main;

{ TScanItem_NewBoxForm }

// Get the location for the box...create it..
procedure TScanItem_NewBoxForm.BoxLocationEdtKeyPress(Sender: TObject;
  var Key: Char);
begin
  // If they press enter, then push that button.
  if Key= #13 then
    self.SetupBoxBtn.Click;
end;

procedure TScanItem_NewBoxForm.BoxSKUEdtKeyPress(Sender: TObject;
  var Key: Char);
begin
  // If they press enter...move to the next box.
  if Key= #13 then
    self.ActiveControl:= BoxLocationEdt;

end;

procedure TScanItem_NewBoxForm.SetupBoxBtnClick(Sender: TObject);
var
  locationObj, boxObj: ISuperObject;
begin
  // Find the Location ID first...
  findLocationID.Params.ParameterByName('locationSKU').Value:= boxLocationEdt.Text;
  if DataModule1.ExecuteRest(findLocationID, 'Validating Location SKU') then
  begin
    locationObj:= SO(findLocationID.Response.Content);
    createBoxRes.Params.ParameterByName('boxSKU').Value:= boxSKUEdt.Text;
    createBoxRes.Params.ParameterByName('boxGroupID').Value:= boxGroupID;
    createBoxRes.Params.ParameterByName('LocationID').Value:= locationObj.AsArray[0].S['id'];
    createBoxRes.Params.ParameterByName('sortJob').Value:= InttoStr(mainForm.currentSortingJobID);
    if DataModule1.ExecuteRest(createBoxRes, 'Creating new Box') then
    begin
      boxObj:= SO(createBoxRes.Response.Content);
      // store the new box ID created, if we need it.
      newBoxID:= boxObj.I['id'];
      modalResult:= mrOK;
    end;
  end;
end;

function TScanItem_NewBoxForm.SetupNewBox(boxGroupID: string): Boolean;
begin
  self.boxGroupID:= boxGroupID;
  boxGroupEdt.Text:= boxGroupID;
  boxLocationEdt.Text:= '';
  boxSKUEdt.Text:= '';
  newBoxID:= -1;
  self.ActiveControl:= boxSKUEdt;
  if ShowModal= mrOK then
    result:= True
  else
    Result:= false;
end;

function TScanItem_NewBoxForm.SetupNewBox(lastItemResp: ISuperObject): Boolean;
begin
  result:= setupNewBox(lastItemResp['sku.boxGroup'].AsString);
end;

end.
