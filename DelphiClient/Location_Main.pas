unit Location_Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Base, Data.Bind.Components,
  Data.Bind.ObjectScope, REST.Client, Vcl.StdCtrls, Vcl.ExtDlgs;

type
  TLocations= class(TObject)
    sku: string;
    name: string;
    id: integer;
    multipleBoxes: Boolean;
  end;

  TLocation_MainForm = class(TbaseForm)
    LoadLocationsBtn: TButton;
    LocationsBox: TListBox;
    AddLocationBtn: TButton;
    EditLocationBtn: TButton;
    DeleteLocationBtn: TButton;
    LocationsGet: TRESTRequest;
    LocationsDelete: TRESTRequest;
    LocationsAdd: TRESTRequest;
    LocationsEdit: TRESTRequest;
    ImportLocationsBtn: TButton;
    openCSVDialog: TOpenTextFileDialog;
    procedure LoadLocationsBtnClick(Sender: TObject);
    procedure DeleteLocationBtnClick(Sender: TObject);
    procedure AddLocationBtnClick(Sender: TObject);
    procedure EditLocationBtnClick(Sender: TObject);
    procedure ImportLocationsBtnClick(Sender: TObject);
  private
    { Private declarations }
    function clearLocations: Boolean;
  public
    { Public declarations }
  end;

var
  Location_MainForm: TLocation_MainForm;

implementation

{$R *.dfm}

uses
  DataModule
  , superObject
  , Location_AddEdit;

procedure TLocation_MainForm.AddLocationBtnClick(Sender: TObject);
var
  newLocationName, newLocationSKU: String;
  newLocationMultipleBoxes: Boolean;
begin
  inherited;
  newLocationname:= '';
  newLocationSKU:= '';
  newLocationMultipleBoxes:= False;
  if Location_AddEditForm.editLocation(newLocationname, newLocationSKU, newLocationMultipleBoxes) then
  begin
    LocationsAdd.Params.ParameterByName('name').Value:= newLocationName;
    LocationsAdd.Params.ParameterByName('locationSKU').Value:= newLocationSKU;
    LocationsAdd.Params.ParameterByName('multipleBoxes').Value:= LowerCase(BooltoStr(newLocationMultipleBoxes, True));
    DataModule1.ExecuteRest(LocationsAdd, 'Adding Location');
    LoadLocationsBtn.Click;
  end;
end;

function TLocation_MainForm.clearLocations: Boolean;
var
  location: TLocations;
begin
  while locationsBox.Count> 0 do
  begin
    location:= TLocations(locationsBox.items.Objects[0]);
    freeandNil(location);
    locationsBox.Items.Delete(0);
  end;
end;

procedure TLocation_MainForm.DeleteLocationBtnClick(Sender: TObject);
begin
  inherited;
  if MessageDlg('Are you sure you wish to remove '+ TLocations(LocationsBox.Items.Objects[locationsBox.ItemIndex]).name, mtConfirmation, [mbYes, mbNo], 0)= mrYes then
  begin
    LocationsDelete.Params.ParameterByName('id').Value:= InttoStr(TLocations(LocationsBox.Items.Objects[locationsBox.ItemIndex]).id);

    DataModule1.ExecuteRest(LocationsDelete, 'Deleting Location');
    LoadLocationsBtnClick(self);
  end;
end;

procedure TLocation_MainForm.EditLocationBtnClick(Sender: TObject);
var
  newLocationName, newLocationSKU: String;
  newLocationMultipleBoxes: Boolean;
begin
  inherited;
  if LocationsBox.ItemIndex> -1 then
  begin
    newLocationname:= TLocations(LocationsBox.Items.Objects[locationsBox.ItemIndex]).name;
    newLocationSKU:= TLocations(LocationsBox.Items.Objects[locationsBox.ItemIndex]).sku;
    newLocationMultipleBoxes:= TLocations(LocationsBox.Items.Objects[locationsBox.ItemIndex]).multipleBoxes;
    if Location_AddEditForm.editLocation(newLocationname, newLocationSKU, newLocationMultipleBoxes) then
    begin
      LocationsEdit.Params.ParameterByName('name').Value:= newLocationName;
      LocationsEdit.Params.ParameterByName('locationSKU').Value:= newLocationSKU;
      LocationsEdit.Params.ParameterByName('multipleBoxes').Value:= LowerCase(BooltoStr(newLocationMultipleBoxes, True));
      LocationsEdit.Params.ParameterByName('id').Value:= InttoStr(TLocations(LocationsBox.Items.Objects[locationsBox.ItemIndex]).id);

      DataModule1.ExecuteRest(LocationsEdit, 'Editing Location');
      LoadLocationsBtn.Click;
    end;
  end
  else
  begin
    MessageDlg('No Location selected to edit.', mtError, [mbOK], 0);
  end;
end;

procedure TLocation_MainForm.ImportLocationsBtnClick(Sender: TObject);
var
  importFile: TextFile;
  fileLine, LocationName, LocationSKU: String;
  firstLineImport, locationMultiples: Boolean;
begin
  inherited;
  firstLineIMport:= true;
  if openCSVDialog.Execute then
  begin
    if MessageDlg('First Line will be ignored.', mtWarning, [mbOk, mbCancel], 0)= mrOk then
    begin
      AssignFile(importFile, openCSVDialog.FileName);
      reset(importFile);
      try
        // Skip the first line.
        readln(importFile, fileLine);
        while not Eof(importFile) do
        begin
          readln(importFile, fileLine);
          LocationName:= copy(fileLine, 1, pos(',', fileLIne)- 1);
          delete(fileLine, 1, pos(',', fileLine));
          LocationSKU:= copy(fileLine, 1, pos(',', fileLIne)- 1);
          delete(fileLine, 1, pos(',', fileLine));
          // fileLIne equal 1 because of original format htat Tom set up.....he had quantity.
          if (fileLine= '1') or (fileLine= 'false') or (fileLine= '0') or (fileLine= 'no') then
            locationMultiples:= False
          else
            locationMultiples:= True;

          if firstLineImport then
          begin
            if MessageDlg('Before continuing, verify that the following is correct for the first line of the file.'+ #13#10#13#10+
              'Location Name: '+ Locationname+ #13#10+
              'Location SKU: '+ LocationSku+ #13#10+
              'Multiples Allows: '+ BooltoStr(locationMultiples, true), mtConfirmation, [mbYes, mbNo], 0)= mrNo then
              exit;
            firstLineImport:= False;
          end;

          LocationsAdd.Params.ParameterByName('name').Value:= Locationname;
          LocationsAdd.Params.ParameterByName('locationSKU').Value:= LocationSku;
          LocationsAdd.Params.ParameterByName('multipleBoxes').Value:= LowerCase(BooltoStr(locationMultiples, True));
          screen.Cursor:= crHourGlass;
          DataModule1.ExecuteRest(LocationsAdd, 'Adding Location');
          screen.Cursor:= crDefault;

        end;

      finally
        CloseFile(importFile);
      end;
    end;
  end;
end;

procedure TLocation_MainForm.LoadLocationsBtnClick(Sender: TObject);
var
  locationsResponse: ISuperObject;
  items: Integer;
  location: TLocations;
begin
  inherited;
  cursor:= crHourGlass;
  try
    clearLocations;

    LocationsGet.Execute;
    locationsResponse:= SO(locationsGet.Response.Content);
    if locationsGet.Response.StatusCode<> 200 then
    begin
      MessageDlg('Unable to fetch locations from server.', mtError, [mbOK], 0);
    end
    else
    begin
      for items := 0 to locationsResponse.AsArray.Length- 1 do
      begin
        location:= TLocations.Create;
        location.id:= locationsResponse.AsArray[items].I['id'];
        location.name:= locationsResponse.AsArray[items].S['name'];
        location.sku:= locationsResponse.AsArray[items].S['locationSKU'];
        location.multipleBoxes:= locationsResponse.AsArray[items].B['multipleBoxes'];
        locationsBox.AddItem(locationsResponse.AsArray[items].S['name']+' - '+ locationsResponse.AsArray[items].S['locationSKU'], location);
      end;
    end;

  finally
    cursor:= crDefault;
  end;
end;

end.
