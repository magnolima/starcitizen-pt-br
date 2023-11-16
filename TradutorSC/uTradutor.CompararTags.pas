unit uTradutor.CompararTags;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
   Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
   FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
   FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
   FireDAC.Comp.DataSet;

type
   TfrmCompararTags = class(TForm)
      ListBox1: TListBox;
      btComparar: TButton;
      btFechar: TButton;
      ListBox2: TListBox;
      Label1: TLabel;
      Label2: TLabel;
      btSalvar: TButton;
      procedure btCompararClick(Sender: TObject);
      procedure btFecharClick(Sender: TObject);
      procedure btSalvarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
   private
      { Private declarations }
   public
      { Public declarations }
   end;

var
   frmCompararTags: TfrmCompararTags;

implementation

uses
   System.StrUtils, System.IOUtils, uTradutor.Main, uTradutor.Comum;

{$R *.dfm}

procedure TfrmCompararTags.btFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TfrmCompararTags.btSalvarClick(Sender: TObject);
const
   ArquivoOriginal = '.\Tags-Diferencas-Original.txt';
   ArquivoTraducao = '.\Tags-Diferencas-Traducao.txt';
var
   Lines: TStrings;
begin

   ShowMessage('A lista de tags será salvar nos arquivos:' + #13#13 +
    ifThen(ListBox1.Items.Count > 0,  '"' + ArquivoOriginal + '"'+#13, '') +
    ifThen(ListBox2.Items.Count > 0,  '"' + ArquivoTraducao + '"'+#13, '') + #13 +
    'na pasta "'+ExtractFilePath(ParamStr(0))+'"');
   if ListBox1.Items.Count > 0 then
      TFile.WriteAllText(ArquivoOriginal, ListBox1.Items.Text);
   if ListBox2.Items.Count > 0 then
      TFile.WriteAllText(ArquivoTraducao, ListBox2.Items.Text);
end;

procedure TfrmCompararTags.FormShow(Sender: TObject);
begin
   btSalvar.Enabled := false;
end;

procedure TfrmCompararTags.btCompararClick(Sender: TObject);
var
   lQuerySource, lQueryTarget: TFDQuery;
   lDifferences: integer;

   procedure LoopTags(ListBox: TListBox);
   begin
      ListBox.Items.BeginUpdate;
      while not lQuerySource.Eof do
      begin
         lQueryTarget.Close;
         lQueryTarget.ParamByName('tag').AsString := lQuerySource.FieldByName('tag').AsString;
         lQueryTarget.Open;
         if lQueryTarget.IsEmpty then
         begin
            ListBox.Items.Add(lQuerySource.FieldByName('tag').AsString);
            inc(lDifferences);
         end;

         lQuerySource.Next;
      end;
      ListBox.Items.EndUpdate;
   end;

begin
   lQuerySource := TFDQuery.Create(Self);
   lQueryTarget := TFDQuery.Create(Self);
   lDifferences := 0;
   ListBox1.Clear;
   ListBox2.Clear;
   try
      lQuerySource.Connection := frmTradutorSC.Connection;
      lQueryTarget.Connection := frmTradutorSC.Connection;
      lQuerySource.SQL.Text := 'select tag from global_' + ORIGINAL_LOCALE + ' order by tag';
      lQueryTarget.SQL.Text := 'select tag from global_' + DEFAULT_LOCALE + ' where tag=:tag';
      lQuerySource.Open;

      // procurar tags depreciadas
      LoopTags(ListBox1);

      lQuerySource.Close;

      lQuerySource.SQL.Text := 'select tag from global_' + DEFAULT_LOCALE + ' order by tag';
      lQueryTarget.SQL.Text := 'select tag from global_' + ORIGINAL_LOCALE + ' where tag=:tag';
      lQuerySource.Open;
      LoopTags(ListBox2);

      if lDifferences = 0 then
         ShowMessage('Não há diferenças entre as Tags');

   finally
      btSalvar.Enabled := (ListBox1.Count > 0)or(ListBox2.Count > 0);
      lQueryTarget.Free;
      lQuerySource.Free;
   end;
end;

end.
