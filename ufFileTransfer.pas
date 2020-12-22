unit ufFileTransfer;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, VirtualTrees, System.Win.ComObj, uxADO,
  Data.DB, Data.Win.ADODB, ufGetID, Vcl.Menus, System.UITypes;

type
  TMainForm = class(TForm)
    MainTree: TVirtualStringTree;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    function LoadFileToBase: OleVariant;
    procedure FormCreate(Sender: TObject);
    procedure LoadFromBase;
    procedure SaveFile;
    procedure N1Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure MainTreeGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure MainTreeEditing(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; var Allowed: Boolean);
    procedure MainTreeNewText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; NewText: string);
    procedure N2Click(Sender: TObject);
  private
	private type
    tDataRec = record
        id:			integer;
        text:		AnsiString;
        data:		TBytes;
        name:		AnsiString;
    	version:	AnsiString;
    end;
  public
    Data: array of tDataRec;
  end;

var
  MainForm: TMainForm;
  fCon: OLEVariant;

const
  adoCon = 'ADODB.Connection';
  adoRec = 'ADODB.Recordset';

implementation

{$R *.dfm}

procedure TMainForm.LoadFromBase;
var
    R:		OleVariant;
    V:		Variant;
    K, Len:	integer;
    M, N:	PVirtualNode;
begin
  MainTree.BeginUpdate;
  try
    MainTree.Clear;
    K := 0;
    R := CreateOleObject(adoRec);
    fCon.GetFile(0, R);
    while not R.EOF do
    begin
      SetLength(Data, K + 1);
      MainTree.AddChild(N, pointer(K));
      Data[K].id := AsInt(R, 0);
      Data[K].text := AsStr(R, 1);
      V := AsVar(R, 2);
      Len := TVarData(V).VArray.Bounds[0].ElementCount;
      SetLength(Data[K].Data, Len);
      Move(TVarData(V).VArray.Data^, Data[K].Data[0], Len);
      Data[K].name := AsStr(R, 3);
      Data[K].version := AsStr(R, 4);
      Inc(K);
      R.MoveNext;
    end;
  finally
  	MainTree.EndUpdate;
  end;
end;

procedure TmainForm.SaveFile;
begin
    if not Assigned(MainTree.FocusedNode) then Exit;

    SaveDialog1.FileName := Data[MainTree.FocusedNode.RowIndex].name;
	if SaveDialog1.Execute then
    begin
        with TFileStream.Create(SaveDialog1.FileName, fmCreate + fmShareCompat) do
        try
            Write(Data[MainTree.FocusedNode.RowIndex].data, Length(Data[MainTree.FocusedNode.RowIndex].name));
        finally
        	Free;
        end;
    end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
	ConnectSQL(fcon);
    LoadFromBase;
end;

function TMainForm.LoadFileToBase: OleVariant;
var
    V:	variant;
    R:	OleVariant;
    N:	PVirtualNode;
begin
  if OpenDialog1.Execute then
  begin
    with TFileStream.Create(OpenDialog1.FileName, fmOpenRead + fmShareCompat) do
    try
        //N := MainTree.AddChild(nil, pointer(Length(Data)));

    	SetLength(Self.Data, Length(Data) + 1);
        SetLength(Data[High(Data)].data, Size);

        R := CreateOleObject(adoRec);

        Read(Data[High(Data)].data[0], Size);
        V := VarArrayCreate([0, Size-1], varByte);
        Move(Data[High(Data)].data[0], tVarData(V).VArray.Data^, Size);

        Data[High(Data)].Name := ExtractFileName(OpenDialog1.FileName);
        with Data[High(Data)] do
        begin
        	fCon.AddPict(0, 0, 0, 4, 0, ExtractFileExt(Name), '', V, Name, R);

        	id := AsInt(R, 0);
            name := AsStr(R, 1);
            version := AsStr(R, 3);
            text := AsStr(R, 4);
        end;
        Result := R;
    finally
      Free;
    end;
  end;
end;

procedure TMainForm.MainTreeEditing(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
begin
    Allowed := Column = 1;
end;

procedure TMainForm.MainTreeGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
begin
  case Column of
    0: CellText := Data[Node.RowIndex].id.ToString;
    1: CellText := Data[Node.RowIndex].text;
    2: CellText := Data[Node.RowIndex].name;
    3: CellText := Data[Node.RowIndex].version;
  end;
end;

procedure TMainForm.MainTreeNewText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; NewText: string);
begin
    var K: integer := node.RowIndex;
    fCon.execute(format('update spr_blob set text=''%s'' where id = %d', [NewText, Data[K].id]));
    Data[K].text := NewText;
end;

procedure TMainForm.N1Click(Sender: TObject);
begin
    LoadFileToBase;
    LoadFromBase;
end;

procedure TMainForm.N2Click(Sender: TObject);
var
	N:	PVirtualNode;
begin
	if not Assigned(MainTree.FocusedNode) then Exit;

    if MessageDlg('Вы действительно хотите удалить файл ' +
	Data[MainTree.FocusedNode.RowIndex].name, mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
        fCon.Execute('delete spr_blob where id=0' + Data[MainTree.FocusedNode.RowIndex].id.ToString);
        ShowMessage('Документ ' + Data[MainTree.FocusedNode.RowIndex].name + ' успешно удален');

        N := MainTree.FocusedNode;
        MainTree.FocusedNode := N.Parent;
        MainTree.DeleteNode(N);
    end;
end;

procedure TMainForm.N3Click(Sender: TObject);
begin
	SaveFile;
end;

end.
