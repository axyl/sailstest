unit ScanItem_AddToBox;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Base, Vcl.StdCtrls, Vcl.ExtCtrls,
  Data.Bind.Components, Data.Bind.ObjectScope, REST.Client;

type
  TScanItem_AddToBoxForm = class(TbaseForm)
    SKUedt: TLabeledEdit;
    GroupBox1: TGroupBox;
    processSKUBtn: TButton;
    GroupBox2: TGroupBox;
    itemsListMmo: TMemo;
    itemDetailsMmo: TMemo;
    findBox: TRESTRequest;
    findSKU: TRESTRequest;
    createItem: TRESTRequest;
    setBoxPacked: TRESTRequest;
    procedure processSKUBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    boxSKU: String;
    boxID, boxGroupID: Integer;
    newBoxNeeded: Boolean;
    function resetForm: Boolean;
    function processNewAddBox: Boolean;
    function processNewItem: Boolean;
    function packBox: Boolean;
  public
    { Public declarations }
  end;

var
  ScanItem_AddToBoxForm: TScanItem_AddToBoxForm;

implementation

{$R *.dfm}

uses
  DataModule
  , superObject
  , MMSystem
  , Main
  , ScanItem_NewBox;

{ TScanItem_AddToBoxForm }

// Create box if necessary and pack Items into it.
procedure TScanItem_AddToBoxForm.FormShow(Sender: TObject);
begin
  inherited;
  resetForm;
end;

function TScanItem_AddToBoxForm.packBox: Boolean;
var
  loopItems: Integer;
begin
  Result:= False;

  if (newBoxNeeded) then
  begin
    if Scanitem_NewBoxForm.SetupNewBox(InttoStr(boxGroupID)) then
    begin
      boxID:= ScanItem_newBoxForm.newBoxID;
      newBoxNeeded:= False;
    end
    else
      exit;
  end;

  // Now pack the items.
  createItem.Params.ParameterByName('packedBy').Value:= MainForm.PackerName.Text;
  createItem.Params.ParameterByName('boxSKU').Value:= boxSKU;
  createItem.Params.ParameterByName('sortJob').Value:= InttoStr(MainForm.currentSortingJobID);
  // Only the item SKU is unique...
  for loopItems := 0 to itemsListMmo.Lines.Count- 1 do
  begin
    createItem.Params.ParameterByName('itemSKU').Value:= itemsListMmo.Lines[loopItems];
    if (DataModule1.ExecuteRest(createItem, 'Adding item to Box')) then
    begin
      itemDetailsMMo.Lines.Add('Packed item: '+ InttoStr(loopItems));
    end
    else
    begin
      itemDetailsMMo.Lines.Add('Failed packing item: '+ InttoStr(loopItems));
      itemDetailsMMo.Lines.Add('Higher items were packed...rest are skipped.');
      exit;
    end;
  end;

  // Now change the box status.
  setBoxPacked.Params.ParameterByName('boxID').Value:= InttoStr(BoxID);
  if (DataModule1.ExecuteRest(setBoxPacked, 'Packing Box')) then
  begin
    itemDetailsMMo.Lines.Add('Box Packed.');
    Result:= True;
  end;

end;

// Processes a new start - where we check if the box already exists etc.
function TScanitem_AddToBoxForm.processNewAddBox: Boolean;
var
  boxResponse: ISuperObject;
begin
  findBox.Params.ParameterByName('boxSKU').Value:= SKUedt.Text;
  if (DataModule1.ExecuteRest(findBox, 'Search for Box')) then
  begin
    // Did we get back a record?
    boxResponse:= SO(findBox.Response.Content);
    if boxResponse.AsArray.Length> 0 then
    begin
      boxID:= boxResponse.AsArray[0].I['id'];
      if boxResponse.AsArray[0].S['status']<>'packing' then
      begin
        itemDetailsMmo.Lines.Add('Existing box is '+ boxResponse.AsArray[0].S['status']+ '.');
        itemDetailsMmo.Lines.Add('Change its status to packing first with the Move Box option.');
        Result:= False;
        exit;
      end;
      newBoxNeeded:= False;
      itemDetailsMMo.Lines.Add('Existing box at '+ boxResponse.AsArray[0].S['location.name']);
    end
    else
    begin
      itemDetailsMmo.Lines.Add('Adding a new box.');
      // Don't really need the following, but just putting in so it's clear.
      newBoxNeeded:= True;
      boxID:= -1;
    end;
    boxSKU:= SKUedt.Text;
    Result:= true
  end
  else
    Result:= False;
end;

// Adding a new item to the array that we'll stick into the box when done...
function TScanItem_AddToBoxForm.processNewItem: Boolean;
var
  skuResponse: ISuperObject;
begin
  findSKU.Params.ParameterByName('sortJob').Value:= InttoStr(MainForm.currentSortingJobID);
  findSKU.Params.ParameterByName('itemSKU').Value:= SKUEdt.Text;
  if (DataModule1.ExecuteRest(findSKU, 'Validating Item SKU')) then
  begin
    skuResponse:= SO(findSKU.Response.Content);
    if (skuResponse.AsArray.Length> 0) then
    begin
      if boxGroupID< 0 then
        boxGroupID:= skuResponse.AsArray[0].I['boxGroup.id']
      else if boxGroupID<> skuResponse.AsArray[0].I['boxGroup.id'] then
      begin
        itemDetailsMMO.Lines.Add('This item belongs to a different Box Group!  Unable to box.');
        Result:= False;
        exit;
      end;

      // if we're still here, then we're okay.
      itemsListMmo.Lines.Add(SKUEdt.text);
      itemDetailsMmo.Lines.Add('Description: '+ skuResponse.AsArray[0].S['description']);
      itemDetailsMmo.Lines.Add('Misc: '+ skuResponse.AsArray[0].S['misc']);
      Result:= True;
    end
    else
    begin
      itemDetailsMmo.Lines.Add('SKU does not exist in imported list.');
      result:= False;
    end;
  end
  else
    result:= false;
end;

// Either a Box is being scanned for packing items, item being scanned or it's a new job...
procedure TScanItem_AddToBoxForm.processSKUBtnClick(Sender: TObject);
begin
  inherited;
  // Clear the details as that shows status etc.
  itemDetailsMmo.Lines.Clear;
  // Is this a new start?
  if boxSKU= '' then
  begin
    // Query for the box...
    if processNewAddBox then
    begin
      SKUedt.EditLabel.Caption:= 'Item SKU... (or Box again to finish adding items)';
      SKUEdt.Text:= '';
      self.Color:= clAqua;
      PlaySound('SystemNotification', 0, SND_ASYNC);
    end
    else
    begin
      self.Color:= clRed;
      PlaySound('SystemExclamation', 0, SND_ASYNC);
    end;
  end
  // Are we finishing up with this box?
  else if (boxSKU= SKUedt.Text) then
  begin
    // Now we're packing/creating the box etc.
    if packBox then
    begin
      resetForm;
      // Colour after reset...ready for next box/items.
      self.Color:= clGreen;
      PlaySound('SystemNotification', 0, SND_ASYNC);
    end
    else
    begin
      self.Color:= clRed;
      PlaySound('SystemExclamation', 0, SND_ASYNC);
    end;
  end
  else
  // Otherwise it's an item to add to this box, to just store the SKU for now...
  begin
    if processNewItem then
    begin
      self.Color:= clAqua;
      SKUEdt.Text:= '';
      PlaySound('SystemNotification', 0, SND_ASYNC);
    end
    else
    begin
      self.Color:= clRed;
      SKUEdt.Text:= '';
      PlaySound('SystemExclamation', 0, SND_ASYNC);
    end;
  end;
end;

// Sets up the form for the initial scan..
function TScanItem_AddToBoxForm.resetForm: Boolean;
begin
  SKUedt.EditLabel.Caption:= 'Box SKU to add items to...';
  self.ActiveControl:= SKUedt;
  itemsListMMo.lines.Clear;
  itemDetailsMmo.lines.Clear;
  boxSKU:= '';
  boxID:= -1;
  boxGroupID:= -1;
  newBoxNeeded:= true;
  SKUedt.Text:= '';
  self.Color:= clBtnFace;

end;

end.
