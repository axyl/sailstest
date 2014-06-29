unit ScanItem_FindBox;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, IPPeerClient, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, superObject;

type
  TScanItem_FindBoxForm = class(TForm)
    Label1: TLabel;
    ItemSKU: TEdit;
    findPackingBoxReq: TRESTRequest;
    RESTResponse1: TRESTResponse;
    mmoItemDetails: TMemo;
    Label2: TLabel;
    mmoItemsList: TMemo;
    Label3: TLabel;
    Label4: TLabel;
    mmoBoxDetails: TMemo;
    boxItemReq: TRESTRequest;
    ProcessScanBtn: TButton;
    BoxLocationLbl: TLabel;
    procedure FormShow(Sender: TObject);
    procedure ProcessScanBtnClick(Sender: TObject);
  private
    boxGroupID: Integer;        // make sure all items match this...
    function findPackingBox: Boolean;
    function boxItems(lastItemResp: ISuperObject): Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ScanItem_FindBoxForm: TScanItem_FindBoxForm;

implementation

{$R *.dfm}

uses
  ScanItem_NewBox,
  Main,
  MMSystem

  ;

(* Pack the items into the specified box... *)
function TScanItem_FindBoxForm.boxItems(lastItemResp: ISuperObject): Boolean;
var
  boxResponse: ISuperObject;
begin
  Result:= False;
  // These two are consistent...
  boxItemReq.Params.ParameterByName('boxSKU').Value:= lastItemResp['box.boxSKU'].AsString;
  boxItemReq.Params.ParameterByName('packedBy').Value:= MainForm.PackerName.Text;
  boxItemReq.Params.ParameterByName('sortJob').Value:= InttoStr(MainForm.currentSortingJobID);

  while mmoItemsList.Lines.Count> 0 do
  begin
    boxItemReq.Params.ParameterByName('sku').Value:= mmoItemsList.Lines[0];
    // Send off the API call.
    boxItemReq.Execute;
    boxResponse:= SO(RestResponse1.Content);
    if restResponse1.StatusCode<> 200 then
    begin
      self.Color:= clRed;
      MessageDlg('Error with top SKU in list.  Server reports error '+ boxResponse['validationErrors'].AsString, mtError, [mbOK], 0);
      MessageDlg('SKUs you can see have not been processed.', mtInformation, [mbOK], 0);
      exit;
    end;
    mmoItemsList.Lines.Delete(0);
  end;
  Result:= True;
end;

function TScanItem_FindBoxForm.findPackingBox: Boolean;
var
  skuValidCheck, validBox: string;
  jsonResponse: ISuperObject;
begin
  self.color:= clBtnFace;   // reset to default.
  findPackingBoxReq.Params.ParameterByName('itemSKU').Value:= itemSKU.Text;
  findPackingBoxReq.Params.ParameterByName('sortJob').Value:= InttoStr(mainform.currentSortingJobID);
  findPackingBoxReq.Execute;
  jsonResponse:= SO(RestResponse1.Content);
  RESTREsponse1.GetSimpleValue('sku', skuValidCheck);
  RestResponse1.GetSimpleValue('box', validBox);
  if (skuValidCheck='invalid') then
  begin
    self.Color:= clRed;
    PlaySound('SystemExclamation', 0, SND_ASYNC);
    MessageDlg('SKU does not exist!', mtError, [mbOK], 0);
  end
  else if (skuValidCheck='box') then
  begin
    // This SKU belongs to a box..so the user is therefore packing the items...

    // but is it the right box?
    if jsonResponse['box.boxGroup'].AsInteger= boxGroupID then
    begin
      self.Color:= clBlue;
      if boxItems(jsonResponse) then
      begin
        self.Color:= clGreen;
        PlaySound('SYSTEMDEFAULT', 0, SND_ASYNC);
        // Reset form.
        self.FormShow(self);
      end
      else
      begin
        PlaySound('SystemExclamation', 0, SND_ASYNC);
        self.Color:= clRed;   // Probably already red...
      end;
    end
    else
    begin
      self.Color:= clRed;
      PlaySound('SystemExclamation', 0, SND_ASYNC);
      MessageDlg('Scanned the wrong box! - Nothing saved...scan the right box!'+ #13#10+ 'This SKU is a box.', mtError, [mbOK], 0);
    end;
  end
  // If not a valid box, but we're already packing...then don't treat it as a new box.
  else if ((validBox= 'none') and (boxGroupID= -1)) then
  begin
    // No open box...
    self.Color:= clAqua;
    PlaySound('SYSTEMQUESTION', 0, SND_ASYNC);
    if Scanitem_NewBoxForm.SetupNewBox(jsonResponse) then
    begin
      // Recursive... add it to the now existing box...
      findPackingBox;
    end
    else
    begin
      // reset.
      FormShow(self);
    end;
  end
  else
  begin
    // Is there no open box?

    // Is this item for a different group of boxes???  If so, don't allow  //was previously checking box.boxGroup
    if ((boxGroupID<> jsonResponse['sku.boxGroup'].AsInteger) and (boxGroupID> -1)) then
    begin
      { TODO : Play a warning sound ??? }
      self.Color:= clRed;
      PlaySound('SystemExclamation', 0, SND_ASYNC);
      MessageDlg('Item belongs to another boxGroup.  Unable to box with this batch.', mtError, [mbOK], 0);
    end
    else
    begin
      PlaySound('SYSTEMDEFAULT', 0, SND_ASYNC);
      // List the Item in the list of items..
      mmoItemsList.Lines.Add(jsonResponse['sku.SKU'].AsString);
      // Specific item details.
      mmoItemdetails.Clear;
      mmoItemDetails.lines.Add('Description: '+ jsonRESponse['sku.description'].AsString);
      mmoItemDetails.lines.Add('Misc: '+ jsonRESponse['sku.misc'].AsString);
      mmoItemDetails.lines.Add('sku: '+ jsonRESponse['sku.SKU'].AsString);
      // Is this the first item?
      if boxGroupID=-1 then
      begin
        // First item we're adding... so set box details and boxGroupID that all items must match.
        boxGroupID:= jsonResponse['box.boxGroup'].AsInteger;

        // Box details...
        mmoBoxDetails.Clear;
        mmoBoxDetails.Lines.Add('Box Location: '+ jsonResponse['box.location.name'].AsString);
        mmoBoxDetails.Lines.Add('sku: '+ jsonResponse['box.boxSKU'].AsString);
        boxLocationLbl.Caption:= 'Box Location: '+ jsonResponse['box.location.name'].AsString;
      end;
    end;
  end;
end;

procedure TScanItem_FindBoxForm.FormShow(Sender: TObject);
begin
  mmoItemDetails.Lines.Clear;
  mmoItemsList.Lines.Clear;
  mmoBoxDetails.Lines.Clear;
  boxLocationLbl.Caption:= '';
  self.FocusControl(itemSKU);

  // TODO : Reset the SKU edit box..
  itemSKU.Text:= '';
  boxGroupID:= -1;
  self.color:= clBtnFace;   // reset to default.
end;

procedure TScanItem_FindBoxForm.ProcessScanBtnClick(Sender: TObject);
begin
  if length(itemSKU.Text)> 0 then
  begin
    findPackingBox;
    self.ActiveControl:= itemSKU;
    ItemSKU.Text:= '';
  end;
end;

end.
