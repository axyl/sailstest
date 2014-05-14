unit importerGUI;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    IdHTTP1: TIdHTTP;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  importFile: TextFile;
  fileLine, sku, category, quantity, description, groupid, misc: String;
  values: TStringList;
begin
  AssignFile(importFile, 'ImportSampleData.csv');
  reset(importFile);
  try
    values:= TStringList.Create;
    // ignore the first line.
    readln(importFile, fileLine);
    while not eof(importFile) do
    begin
      readln(importFile, fileLine);

      sku:= copy(fileLine, 1, pos(',', fileLine)- 1);
      delete(fileLine, 1, pos(',', fileLine));

      category:= copy(fileLine, 1, pos(',', fileLine)- 1);
      delete(fileLine, 1, pos(',', fileLine));

      quantity:= copy(fileLine, 1, pos(',', fileLine)- 1);
      delete(fileLine, 1, pos(',', fileLine));

      description:= copy(fileLine, 1, pos(',', fileLine)- 1);
      delete(fileLine, 1, pos(',', fileLine));

      groupID:= copy(fileLine, 1, pos(',', fileLine)- 1);
      delete(fileLine, 1, pos(',', fileLine));

      misc:= fileLine;

      values.Clear;
      values.Add('sku='+ sku);
      values.Add('category='+ category);
      values.Add('quantity='+ quantity);
      values.Add('description='+ description);
      values.Add('boxgroup='+ groupID);
      values.Add('misc='+ misc);

      try
        idHttp1.Post('http://localhost:1337/sku/create?', values);
      except
        memo1.lines.add(idHttp1.ResponseText);
      end;


      memo1.lines.Add(sku);


    end;



  finally
    closeFile(importFile);
  end;
end;

end.
