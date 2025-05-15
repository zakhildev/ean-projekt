unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, NewtonUtils,
  Vcl.NumberBox, Vcl.ComCtrls;

type
  TMainWindow = class(TForm)
    XNumBox_Real: TNumberBox;
    XLabel_Real: TLabel;
    YNumBox_Real: TNumberBox;
    YLabel_Real: TLabel;
    AddPointBtn_Real: TButton;
    PointsList_Real: TListBox;
    SectionLabel1_Real: TLabel;
    RemovePointBtn_Real: TButton;
    ComputeCoefsBtn_Real: TButton;
    Pages: TPageControl;
    RealTab: TTabSheet;
    AuthorLabel: TLabel;
    TabSheet1: TTabSheet;
    SectionLabel2_Real: TLabel;
    CoefBox_Real: TListBox;
    procedure OnEscKeyPress(Sender: TObject; var Key: Char);
    procedure AddPointBtn_RealClick(Sender: TObject);
    procedure RemovePointBtn_RealClick(Sender: TObject);
    procedure ComputeCoefsBtn_RealClick(Sender: TObject);
  private
    PointsX_Real: TExtendedArray;
    PointsY_Real: TExtendedArray;
    Coefficients_Real: TExtendedArray;
    PointsX_Unit: TExtendedArray;
    PointsY_Unit: TExtendedArray;
    Coefficients_Unit: TExtendedArray;
    PointsX_General: TExtendedArray;
    PointsY_General: TExtendedArray;
    Coefficients_General: TExtendedArray;
  end;

var
  MainWindow: TMainWindow;

implementation

{$R *.dfm}

procedure TMainWindow.OnEscKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #27) then
    Close;
end;

procedure TMainWindow.AddPointBtn_RealClick(Sender: TObject);
begin
  var x: Extended := XNumBox_Real.Value;
  var y: Extended := YNumBox_Real.Value;
  PointsX_Real := PointsX_Real + [x];
  PointsY_Real := PointsY_Real + [y];
  PointsList_Real.AddItem('(' + x.ToString() + '; ' + y.ToString() + ')', nil);
  XNumBox_Real.Value := 0;
  YNumBox_Real.Value := 0;
end;

procedure TMainWindow.RemovePointBtn_RealClick(Sender: TObject);
begin
  if PointsList_Real.ItemIndex = 0 then begin
    PointsX_Real := Copy(PointsX_Real, 1, High(PointsX_Real));
    PointsY_Real := Copy(PointsY_Real, 1, High(PointsY_Real));
  end
  else begin
    Delete(PointsX_Real, PointsList_Real.ItemIndex, PointsList_Real.ItemIndex);
    Delete(PointsY_Real, PointsList_Real.ItemIndex, PointsList_Real.ItemIndex);
  end;
  PointsList_Real.DeleteSelected();
end;

procedure TMainWindow.ComputeCoefsBtn_RealClick(Sender: TObject);
begin
  if (Length(PointsX_Real) <= 0) then
  begin
    MessageDlg('Nie można obliczcyć współczynników, gdy nie wprowadzono żadnych punktów', mtError, [mbOK], 0, mbOK);
    Exit;
  end;
  CoefBox_Real.Clear;
  NewtonExtended(PointsX_Real, PointsY_Real, Coefficients_Real);
  var buffer := '';
  for var i := 0 to High(Coefficients_Real) do
  begin
    buffer := buffer + Coefficients_Real[i].ToString();
    buffer := buffer + sLineBreak;
  end;
  MessageDlg(buffer, mtInformation, [mbOK], 0, mbOK);
  for var i := Low(Coefficients_Real) to High(Coefficients_Real) do
  begin
    CoefBox_Real.AddItem('Współczynnik x' + i.ToString + ': ' + Coefficients_Real[i].ToString, nil);
  end;
end;

end.
