unit uTradutor.NovaTag;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfrmNovaTag = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    btnCancel: TButton;
    btnOK: TButton;
    mmTraducao: TMemo;
    edtTag: TEdit;
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmNovaTag: TfrmNovaTag;

implementation

{$R *.dfm}

procedure TfrmNovaTag.btnCancelClick(Sender: TObject);
begin
   Close;
end;

end.
