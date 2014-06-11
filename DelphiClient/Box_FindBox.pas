unit Box_FindBox;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Base, Vcl.Grids, Vcl.StdCtrls,
  Vcl.ExtCtrls, Data.Bind.Components, Data.Bind.ObjectScope, REST.Client;

type
  TBox_FindBoxForm = class(TbaseForm)
    itemSKUFindEdt: TLabeledEdit;
    FindItemSKUBtn: TButton;
    BoxesList: TStringGrid;
    box_FindItem: TRESTRequest;
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FindItemSKUBtnClick(Sender: TObject);
  private
    { Private declarations }
    function ResetForm(justGrid: Boolean= false): Boolean;
  public
    { Public declarations }
  end;

var
  Box_FindBoxForm: TBox_FindBoxForm;

implementation

{$R *.dfm}

uses DataModule
  , superObject
  ;

procedure TBox_FindBoxForm.FindItemSKUBtnClick(Sender: TObject);
var
  jsonResponse: ISuperObject;
  boxes: Integer;
begin
  inherited;
  box_FindItem.Params.ParameterByName('ItemSKU').Value:= itemSKUFindEdt.Text;

  if DataModule1.ExecuteRest(box_FindItem, 'Finding Items in Boxes') then
  begin
    jsonResponse:= SO(box_FindItem.Response.Content);
    BoxesList.RowCount:= jsonResponse.AsArray.Length+ 1;
    for boxes := 0 to jsonResponse.AsArray.Length- 1 do
    begin
      BoxesList.Cells[0, boxes+ 1]:= jsonResponse.AsArray[boxes].S['location.name'];
      BoxesList.Cells[1, boxes+ 1]:= jsonResponse.AsArray[boxes].S['boxSKU'];
      BoxesList.Cells[2, boxes+ 1]:= InttoStr(jsonResponse.AsArray[boxes].A['items'].Length);
      BoxesList.Cells[3, boxes+ 1]:= jsonResponse.AsArray[boxes].S['status'];
    end;
  end;
end;

procedure TBox_FindBoxForm.FormResize(Sender: TObject);
var
  gridCols: Integer;
  defColWidth: Integer;
begin
  inherited;
  // Resize the Grid Columns.
  defColWidth:= Trunc(BoxesList.ClientWidth/ 6);
  for gridCols := 0 to BoxesList.ColCount- 1 do
  begin
    if gridCols= 0 then
      BoxesList.ColWidths[gridCols]:= defColWidth* 3
    else
      BoxesList.ColWidths[gridCols]:= defColWidth;
  end;
end;

procedure TBox_FindBoxForm.FormShow(Sender: TObject);
begin
  inherited;
  ResetForm;
end;

function TBox_FindBoxForm.ResetForm(justGrid: Boolean= false): Boolean;
var
  gridCols: Integer;
begin
  if not justGrid then
    itemSKUFindEdt.Text:= '';

  for gridCols:= 0 to BoxesList.ColCount- 1 do
  begin
    BoxesList.Cols[gridCols].Clear;
  end;
  BoxesList.RowCount:= 2;
  BoxesList.FixedRows:= 1;
  BoxesList.ColCount:= 4;
  BoxesList.Cells[0, 0]:= 'Location';
  BoxesList.Cells[1, 0]:= 'Box SKU';
  BoxesList.Cells[2, 0]:= 'Item Count';
  BoxesList.Cells[3, 0]:= 'Box Status';
end;

end.
