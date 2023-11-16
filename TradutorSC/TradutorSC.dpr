program TradutorSC;

uses
  Vcl.Forms,
  uTradutor.Main in 'uTradutor.Main.pas' {frmTradutorSC},
  Vcl.Themes,
  Vcl.Styles,
  uTradutor.Sobre in 'uTradutor.Sobre.pas' {frmSobre},
  uTradutor.Comum in 'uTradutor.Comum.pas',
  uTradutor.Novatag in 'uTradutor.Novatag.pas' {frmNovaTag},
  uTradutor.CompararTags in 'uTradutor.CompararTags.pas' {frmCompararTags};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Stellar Dark');
  Application.CreateForm(TfrmTradutorSC, frmTradutorSC);
  Application.CreateForm(TfrmSobre, frmSobre);
  Application.CreateForm(TfrmNovaTag, frmNovaTag);
  Application.CreateForm(TfrmCompararTags, frmCompararTags);
  Application.Run;
end.
