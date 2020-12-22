program FileTransfer;

uses
  Vcl.Forms,
  ufFileTransferFrame in 'ufFileTransferFrame.pas' {MainFrame},
  ufMainForm in 'ufMainForm.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
