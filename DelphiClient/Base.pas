unit Base;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DataModule;

type
  TbaseForm = class(TForm)
    procedure ControlBoxKeyPressEnterCheck(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  baseForm: TbaseForm;

implementation

{$R *.dfm}

procedure TbaseForm.ControlBoxKeyPressEnterCheck(Sender: TObject; var Key: Char);
begin
  // If the user presses enter (Barcode scanners do this) then this moves the selection to the next edit box.
   If Key = #13 Then Begin
    If HiWord(GetKeyState(VK_SHIFT)) <> 0 then
     SelectNext(Sender as TWinControl,False,True)
    else
     SelectNext(Sender as TWinControl,True,True) ;
     Key := #0
   end;
end;

end.
