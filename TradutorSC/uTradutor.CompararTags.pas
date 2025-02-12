unit uTradutor.CompararTags;

interface

uses
	Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
	Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
	FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
	FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
	FireDAC.Comp.DataSet, Vcl.Menus;

type
	TfrmCompararTags = class(TForm)
		lbTagOriginal: TListBox;
		btComparar: TButton;
		btFechar: TButton;
		lbTagTraducao: TListBox;
		Label1: TLabel;
		Label2: TLabel;
		btSalvar: TButton;
		btRemoverTags: TButton;
		btCopiarTags: TButton;
		PopupMenu1: TPopupMenu;
		Copiar1: TMenuItem;
		btAtualizarTagsVazias: TButton;
		procedure btCompararClick(Sender: TObject);
		procedure btFecharClick(Sender: TObject);
		procedure btSalvarClick(Sender: TObject);
		procedure FormShow(Sender: TObject);
		procedure btRemoverTagsClick(Sender: TObject);
		procedure btCopiarTagsClick(Sender: TObject);
		procedure btAtualizarTagsVaziasClick(Sender: TObject);
	private
		{ Private declarations }
	public
		{ Public declarations }
	end;

var
	frmCompararTags: TfrmCompararTags;

implementation

uses
	System.StrUtils, System.IOUtils, uTradutor.Main, uTradutor.Comum, ClipBrd;

{$R *.dfm}

procedure TfrmCompararTags.btCopiarTagsClick(Sender: TObject);
var
	lQuerySource, lQueryTarget: TFDQuery;
	tag: string;
begin
	lQuerySource := TFDQuery.Create(Self);
	lQueryTarget := TFDQuery.Create(Self);
	try
		lQuerySource.Connection := frmTradutorSC.Connection;
		lQueryTarget.Connection := frmTradutorSC.Connection;
		Screen.Cursor := crHourGlass;
		btCopiarTags.Enabled := false;
		for tag in lbTagOriginal.Items do
		begin
			lQueryTarget.Close;
			lQueryTarget.SQL.Text := 'select tag,value from global_' + TRANSLATED_LOCALE + ' where tag=:tag';
			lQueryTarget.ParamByName('tag').AsString := tag;
			lQueryTarget.Open;
			if lQueryTarget.IsEmpty then
			begin
				lQueryTarget.SQL.Text := 'INSERT INTO global_' + TRANSLATED_LOCALE +
				  ' (Tag, Value, Comment, Changed, New) VALUES (:Tag,:Value, :Comment, :Changed, :New)';
				frmTradutorSC.UpdateTableRow(lQueryTarget, lQueryTarget.ParamByName('tag').AsString,
				  lQueryTarget.ParamByName('value').AsString, true);
			end;
		end;

	finally
		Screen.Cursor := crDefault;
		lQuerySource.Free;
		lQueryTarget.Free;
	end;

end;

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

	ShowMessage('The list of tags will be saved in the files:' + #13#13 + ifThen(lbTagOriginal.Items.Count > 0,
	  '"' + ArquivoOriginal + '"' + #13, '') + ifThen(lbTagTraducao.Items.Count > 0, '"' + ArquivoTraducao + '"' + #13,
	  '') + #13 + 'Folder: "' + ExtractFilePath(ParamStr(0)) + '"');
	if lbTagOriginal.Items.Count > 0 then
		TFile.WriteAllText(ArquivoOriginal, lbTagOriginal.Items.Text);
	if lbTagTraducao.Items.Count > 0 then
		TFile.WriteAllText(ArquivoTraducao, lbTagTraducao.Items.Text);
end;

procedure TfrmCompararTags.btAtualizarTagsVaziasClick(Sender: TObject);
var
	lQuerySource, lQueryTarget: TFDQuery;
	value: string;
	Count: integer;

	function GetValueFromOriginal: string;
	begin
		lQuerySource.Close;
		lQuerySource.ParamByName('tag').AsString := lQueryTarget.FieldByName('tag').AsString;
		lQuerySource.Open;
		Result := lQuerySource.FieldByName('value').AsString;
	end;

	procedure SetValueToTranslation(const value: string; const id: integer);
	var
		lQuery: TFDQuery;
	begin
		lQuery := TFDQuery.Create(Self);
		try
			lQuery.Connection := frmTradutorSC.Connection;
			lQuery.SQL.Text := 'UPDATE global_' + TRANSLATED_LOCALE + ' set VALUE=:value where Id=:id;';
			lQuery.ParamByName('value').AsString := value;
			lQuery.ParamByName('id').AsInteger := id;
			lQuery.ExecSQL;
			inc(Count);
		finally
			lQuery.Free;
		end;
	end;

begin

	lQuerySource := TFDQuery.Create(Self);
	lQueryTarget := TFDQuery.Create(Self);

	try
		Screen.Cursor := crHourGlass;
		btAtualizarTagsVazias.Enabled := false;
		lQuerySource.Connection := frmTradutorSC.Connection;
		lQueryTarget.Connection := frmTradutorSC.Connection;
		lQuerySource.SQL.Text := 'SELECT value from global_' + ORIGINAL_LOCALE + ' where tag=:tag';
		lQueryTarget.SQL.Text := 'SELECT id, tag from global_' + TRANSLATED_LOCALE + ' where value='''' ';
		lQueryTarget.Open;
		Count := 0;
		while not lQueryTarget.Eof do
		begin
			value := GetValueFromOriginal();
			if value <> '' then
				SetValueToTranslation(value, lQueryTarget.FieldByName('id').AsInteger);

			lQueryTarget.Next;
		end;

	finally
		Screen.Cursor := crDefault;
		lQuerySource.Free;
		lQueryTarget.Free;
	end;

	if Count > 0 then
		ShowMessage('Empty translation tags have been filled with the original English value.' + #13 + 'Total updates: ' +
		  Count.ToString)
	else
		ShowMessage('No empty tags found without matching original');
end;

procedure TfrmCompararTags.btRemoverTagsClick(Sender: TObject);
var
	lQueryTarget: TFDQuery;
	tag: string;
begin
	lQueryTarget := TFDQuery.Create(Self);
	lQueryTarget.Connection := frmTradutorSC.Connection;

	// could be better delete from .... in (tag, tag, tag...)
	// but we're doing this way due sqlite restrictions
	try
		Screen.Cursor := crHourGlass;
		btRemoverTags.Enabled := false;
		lQueryTarget.SQL.Text := 'DELETE from global_' + TRANSLATED_LOCALE + ' where tag=:tag;';
		for tag in lbTagTraducao.Items do
		begin
			lQueryTarget.Close;
			lQueryTarget.ParamByName('tag').AsString := tag;
			try
				lQueryTarget.ExecSQL;
			except
				ShowMessage('Error to delete tag "' + tag + '"');
			end;
		end;
	finally
		Screen.Cursor := crDefault;
		lQueryTarget.Free;
	end;

end;

procedure TfrmCompararTags.FormShow(Sender: TObject);
begin
	btSalvar.Enabled := false;
	btRemoverTags.Enabled := false;
	btCopiarTags.Enabled := false;
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
	lbTagOriginal.Clear;
	lbTagTraducao.Clear;

	try
		Screen.Cursor := crHourGlass;
		lQuerySource.Connection := frmTradutorSC.Connection;
		lQueryTarget.Connection := frmTradutorSC.Connection;

		lQuerySource.SQL.Text := 'select tag from global_' + TRANSLATED_LOCALE + ' order by tag';
		lQueryTarget.SQL.Text := 'select tag from global_' + ORIGINAL_LOCALE + ' where tag=:tag';
		lQuerySource.Open;

		// procurar tags obsoletas
		LoopTags(lbTagTraducao);

		lQuerySource.Close;
		lQuerySource.SQL.Text := 'select tag from global_' + ORIGINAL_LOCALE + ' order by tag';
		lQueryTarget.SQL.Text := 'select tag from global_' + TRANSLATED_LOCALE + ' where tag=:tag';
		lQuerySource.Open;

		// procurar tags novas
		LoopTags(lbTagOriginal);

		if lDifferences = 0 then
			ShowMessage('There are no differences between the Tags');

	finally
		Screen.Cursor := crDefault;
		btSalvar.Enabled := (lbTagOriginal.Count > 0) or (lbTagTraducao.Count > 0);
		btCopiarTags.Enabled := lbTagOriginal.Items.Count > 0;
		btRemoverTags.Enabled := lbTagTraducao.Items.Count > 0;

		lQueryTarget.Free;
		lQuerySource.Free;
	end;

end;

end.
