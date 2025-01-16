unit uTradutor.Sobre;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
   Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, System.Skia, Vcl.Skia, Vcl.StdCtrls,
   Vcl.Imaging.pngimage;

const
	AUTHOR = '2025 por Magno Lima';

type
   TfrmSobre = class(TForm)
      Image2: TImage;
      Button1: TButton;
      SkLabel1: TSkLabel;
      SkLabel2: TSkLabel;
      SkLabel3: TSkLabel;
      Panel1: TPanel;
      procedure Button1Click(Sender: TObject);
   private
      { Private declarations }
   public
      { Public declarations }
   end;

var
   frmSobre: TfrmSobre;

implementation

uses
   uTradutor.Comum;

{$R *.dfm}

procedure TfrmSobre.Button1Click(Sender: TObject);
begin
   Close;
end;

end.
