program FileTransfer;

uses
  Vcl.Forms,
  ufFileTransfer in 'ufFileTransfer.pas' {MainForm},
  ufGetID in 'ufGetID.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
