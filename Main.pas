unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, NewtonUtils,
  Vcl.NumberBox, Vcl.ComCtrls, IntervalArithmetic32and64, StrUtils;

type
  TMainWindow = class(TForm)
    XLabel_Real: TLabel;
    YLabel_Real: TLabel;
    AddPointBtn_Real: TButton;
    PointsList_Real: TListBox;
    SectionLabel1_Real: TLabel;
    RemovePointBtn_Real: TButton;
    ComputeCoefsBtn_Real: TButton;
    Pages: TPageControl;
    RealTab: TTabSheet;
    AuthorLabel: TLabel;
    SectionLabel2_Real: TLabel;
    CoefBox_Real: TListBox;
    SectionLabel3_Real: TLabel;
    InterpolXLabel_Real: TLabel;
    InterpolNumBoxX_Real: TNumberBox;
    Results_Real: TListBox;
    ComputeResultsBtn_Real: TButton;
    UnitTab: TTabSheet;
    ComputeResultsBtn_Unit: TButton;
    Label1: TLabel;
    Label2: TLabel;
    RemovePointBtn_Unit: TButton;
    Label3: TLabel;
    YNumBox_Unit: TNumberBox;
    PointsList_Unit: TListBox;
    ComputeCoefsBtn_Unit: TButton;
    Label4: TLabel;
    InterpolNumBoxX_Unit: TNumberBox;
    Results_Unit: TListBox;
    CoefBox_Unit: TListBox;
    AddPointBtn_Unit: TButton;
    Label5: TLabel;
    Label6: TLabel;
    XNumBox_Real: TNumberBox;
    YNumBox_Real: TNumberBox;
    XNumBox_Unit: TNumberBox;
    GeneralTab: TTabSheet;
    XNumBoxLeft_General: TNumberBox;
    ComputeResultsBtn_General: TButton;
    Label7: TLabel;
    Label8: TLabel;
    RemovePointBtn_General: TButton;
    Label9: TLabel;
    XNumBoxRight_General: TNumberBox;
    PointsList_General: TListBox;
    CoefBox_General: TListBox;
    Label10: TLabel;
    InterpolNumBoxXLeft_General: TNumberBox;
    Results_General: TListBox;
    AddPointBtn_General: TButton;
    Label11: TLabel;
    Label12: TLabel;
    ComputeCoefsBtn_General: TButton;
    Label13: TLabel;
    Label14: TLabel;
    YNumBoxLeft_General: TNumberBox;
    YNumBoxRight_General: TNumberBox;
    Label15: TLabel;
    InterpolNumBoxXRight_General: TNumberBox;
    procedure OnEscKeyPress(Sender: TObject; var Key: Char);
    procedure AddPointBtn_RealClick(Sender: TObject);
    procedure RemovePointBtn_RealClick(Sender: TObject);
    procedure ComputeCoefsBtn_RealClick(Sender: TObject);
    procedure ComputeResultsBtn_RealClick(Sender: TObject);
    procedure AddPointBtn_UnitClick(Sender: TObject);
    procedure RemovePointBtn_UnitClick(Sender: TObject);
    procedure ComputeCoefsBtn_UnitClick(Sender: TObject);
    procedure OnRednderIntervalItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure OnMeasureIntervalItem(Control: TWinControl; Index: Integer;
      var Height: Integer);
    procedure ComputeResultsBtn_UnitClick(Sender: TObject);
    procedure AddPointBtn_GeneralClick(Sender: TObject);
    procedure RemovePointBtn_GeneralClick(Sender: TObject);
    procedure ComputeCoefsBtn_GeneralClick(Sender: TObject);
    procedure ComputeResultsBtn_GeneralClick(Sender: TObject);
  private
    PointsX_Real: TExtendedArray;
    PointsY_Real: TExtendedArray;
    Coefficients_Real: TExtendedArray;
    PointsX_Unit: TIntervalArray;
    PointsY_Unit: TIntervalArray;
    Coefficients_Unit: TIntervalArray;
    PointsX_General: TIntervalArray;
    PointsY_General: TIntervalArray;
    Coefficients_General: TIntervalArray;
  end;

var
  MainWindow: TMainWindow;

implementation

{$R *.dfm}

procedure TMainWindow.OnMeasureIntervalItem(Control: TWinControl; Index: Integer; var Height: Integer);
begin
  Height := 35; // Wysokość elementu w TListBox
end;

procedure TMainWindow.OnRednderIntervalItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
var
  Bitmap: TBitmap;
  OffsetY, OffsetX: Integer;
  IntervalStrings: TArray<string>;
  LineHeight: Integer;
begin
  with (Control as TListBox).Canvas do
  begin
    FillRect(Rect); // Wyczyszczenie zawartości TListBox

    OffsetX := 4;
    OffsetY := Rect.Top + 2;
    LineHeight := TextHeight('Hg');

    Bitmap := TBitmap((Control as TListBox).Items.Objects[Index]);
    if Assigned(Bitmap) then
    begin
      Draw(Rect.Left + OffsetX, OffsetY, Bitmap);
      OffsetX := OffsetX + Bitmap.Width + 6;
    end;

    IntervalStrings := (Control as TListBox).Items[Index].Split(['|']);
    if Length(IntervalStrings) > 0 then
      TextOut(Rect.Left + OffsetX, OffsetY, IntervalStrings[0]);
    if Length(IntervalStrings) > 1 then
      TextOut(Rect.Left + OffsetX, OffsetY + LineHeight, IntervalStrings[1]);
  end;
end;

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
  Coefficients_Real := [];
  CoefBox_Real.Clear;
  Results_Real.Clear;
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
  Coefficients_Real := [];
  CoefBox_Real.Clear;
  Results_Real.Clear;
end;

procedure TMainWindow.ComputeCoefsBtn_RealClick(Sender: TObject);
begin
  if (Length(PointsX_Real) <= 0) then
  begin
    MessageDlg('Nie można obliczcyć współczynników, gdy nie wprowadzono punktów!', mtError, [mbOK], 0, mbOK);
    Exit;
  end;
  CoefBox_Real.Clear;
  NewtonExtended(PointsX_Real, PointsY_Real, Coefficients_Real);
  for var i := Low(Coefficients_Real) to High(Coefficients_Real) do
  begin
    CoefBox_Real.AddItem('Współczynnik c' + i.ToString + ': ' + Coefficients_Real[i].ToString, nil);
  end;
end;

procedure TMainWindow.ComputeResultsBtn_RealClick(Sender: TObject);
var
  InterpolResult: Extended;
begin
  if (Length(Coefficients_Real) <= 0) then
  begin
    MessageDlg('Nie można obliczcyć wartości interpolowanej, gdy nie obliczono współczynników!', mtError, [mbOK], 0, mbOK);
    Exit;
  end;
  ComputeInterpolatedExtendedValue(InterpolNumBoxX_Real.Value, PointsX_Real, Coefficients_Real, InterpolResult);
  Results_Real.AddItem('f('+ InterpolNumBoxX_Real.Value.ToString + ') = ' + InterPolResult.ToString, nil);
  InterpolNumBoxX_Real.Value := 0;
end;

procedure TMainWindow.AddPointBtn_UnitClick(Sender: TObject);
begin
  var x: Interval := int_read(XNumBox_Unit.Value.ToString);
  var y: Interval := int_read(YNumBox_Unit.Value.ToString);
  PointsX_Unit := PointsX_Unit + [x];
  PointsY_Unit := PointsY_Unit + [y];
  var leftX, rightX, leftY, rightY: string;
  iends_to_strings(x, leftX, rightX);
  iends_to_strings(y, leftY, rightY);
  PointsList_Unit.AddItem('X:[' + leftX + '; ' + rightX + '] |Y:['  + leftY + '; ' + rightY + ']', nil);
  XNumBox_Unit.Value := 0;
  YNumBox_Unit.Value := 0;
  Coefficients_Unit := [];
  CoefBox_Unit.Clear;
  Results_Unit.Clear;
end;

procedure TMainWindow.RemovePointBtn_UnitClick(Sender: TObject);
begin
  if PointsList_Unit.ItemIndex = 0 then begin
    PointsX_Unit := Copy(PointsX_Unit, 1, High(PointsX_Unit));
    PointsY_Unit := Copy(PointsY_Unit, 1, High(PointsY_Unit));
  end
  else begin
    Delete(PointsX_Unit, PointsList_Unit.ItemIndex, PointsList_Unit.ItemIndex);
    Delete(PointsY_Unit, PointsList_Unit.ItemIndex, PointsList_Unit.ItemIndex);
  end;
  PointsList_Unit.DeleteSelected();
  Coefficients_Unit := [];
  CoefBox_Unit.Clear;
  Results_Unit.Clear;
end;

procedure TMainWindow.ComputeCoefsBtn_UnitClick(Sender: TObject);
begin
  if (Length(PointsX_Unit) <= 0) then
  begin
    MessageDlg('Nie można obliczcyć współczynników, gdy nie wprowadzono punktów!', mtError, [mbOK], 0, mbOK);
    Exit;
  end;
  CoefBox_Unit.Clear;
  NewtonInterval(PointsX_Unit, PointsY_Unit, Coefficients_Unit);
  for var i := Low(Coefficients_Unit) to High(Coefficients_Unit) do
  begin
    var left, right: string;
    iends_to_strings(Coefficients_Unit[i], left, right);
    CoefBox_Unit.AddItem('Współczynnik c' + i.ToString + ': [' + left + #13#10 + right + ']', nil);
  end;
end;

procedure TMainWindow.ComputeResultsBtn_UnitClick(Sender: TObject);
var
  InterpolResult: Interval;
  inL, inR, outL, outR: string;
begin
  if (Length(Coefficients_Unit) <= 0) then
  begin
    MessageDlg('Nie można obliczcyć wartości interpolowanej, gdy nie obliczono współczynników!', mtError, [mbOK], 0, mbOK);
    Exit;
  end;
  var InputInterval := int_read(InterpolNumBoxX_Unit.Value.ToString);
  iends_to_strings(InputInterval, inL, inR);
  ComputeInterpolatedIntervalValue(InputInterval, PointsX_Unit, Coefficients_Unit, InterpolResult);
  iends_to_strings(InterpolResult, outL, outR);
  Results_Unit.AddItem('f(['+ inL + '; ' + inR + ']) = [' + outL + '; ' + outR + ']   Szerokość: ' + int_width(InterpolResult).ToString, nil);
  InterpolNumBoxX_Unit.Value := 0;
end;

procedure TMainWindow.AddPointBtn_GeneralClick(Sender: TObject);
var
  x, y: Interval;
begin
  if not (XNumBoxLeft_General.Value <= XNumBoxRight_General.Value) then
  begin
    MessageDlg('Przedział współrzędnej X zawiera błąd. Jego lewy koniec musi być mniejszy lub równy prawemu!', mtError, [mbOK], 0, mbOK);
    Exit;
  end;

  if not (YNumBoxLeft_General.Value <= YNumBoxRight_General.Value) then
  begin
    MessageDlg('Przedział współrzędnej Y zawiera błąd. Jego lewy koniec musi być mniejszy lub równy prawemu!', mtError, [mbOK], 0, mbOK);
    Exit;
  end;

  x.a := left_read(XNumBoxLeft_General.Value.ToString);
  x.b := right_read(XNumBoxRight_General.Value.ToString);
  y.a := left_read(YNumBoxLeft_General.Value.ToString);
  y.b := right_read(YNumBoxRight_General.Value.ToString);
  PointsX_General := PointsX_General + [x];
  PointsY_General := PointsY_General + [y];
  var leftX, rightX, leftY, rightY: string;
  iends_to_strings(x, leftX, rightX);
  iends_to_strings(y, leftY, rightY);
  PointsList_General.AddItem('X:[' + leftX + '; ' + rightX + '] |Y:['  + leftY + '; ' + rightY + ']', nil);
  XNumBoxLeft_General.Value := 0;
  XNumBoxRight_General.Value := 0;
  YNumBoxLeft_General.Value := 0;
  YNumBoxRight_General.Value := 0;
  Coefficients_General := [];
  CoefBox_General.Clear;
  Results_General.Clear;
end;

procedure TMainWindow.RemovePointBtn_GeneralClick(Sender: TObject);
begin
  if PointsList_General.ItemIndex = 0 then begin
    PointsX_General := Copy(PointsX_General, 1, High(PointsX_General));
    PointsY_General := Copy(PointsY_General, 1, High(PointsY_General));
  end
  else begin
    Delete(PointsX_General, PointsList_General.ItemIndex, PointsList_General.ItemIndex);
    Delete(PointsY_General, PointsList_General.ItemIndex, PointsList_General.ItemIndex);
  end;
  PointsList_General.DeleteSelected();
  Coefficients_General := [];
  CoefBox_General.Clear;
  Results_General.Clear;
end;

procedure TMainWindow.ComputeCoefsBtn_GeneralClick(Sender: TObject);
begin
  if (Length(PointsX_General) <= 0) then
  begin
    MessageDlg('Nie można obliczcyć współczynników, gdy nie wprowadzono punktów!', mtError, [mbOK], 0, mbOK);
    Exit;
  end;
  CoefBox_General.Clear;
  NewtonInterval(PointsX_General, PointsY_General, Coefficients_General);
  for var i := Low(Coefficients_General) to High(Coefficients_General) do
  begin
    var left, right: string;
    iends_to_strings(Coefficients_General[i], left, right);
    CoefBox_General.AddItem('Współczynnik c' + i.ToString + ': [' + left + #13#10 + right + ']', nil);
  end;
end;

procedure TMainWindow.ComputeResultsBtn_GeneralClick(Sender: TObject);
var
  InterpolResult, InputInterval: Interval;
  inL, inR, outL, outR: string;
begin
  if (Length(Coefficients_General) <= 0) then
  begin
    MessageDlg('Nie można obliczcyć wartości interpolowanej, gdy nie obliczono współczynników!', mtError, [mbOK], 0, mbOK);
    Exit;
  end;

  if not (InterpolNumBoxXLeft_General.Value <= InterpolNumBoxXRight_General.Value) then
  begin
    MessageDlg('Przedział współrzędnej X wartości interpolowanej zawiera błąd. Jego lewy koniec musi być mniejszy lub równy prawemu!', mtError, [mbOK], 0, mbOK);
    Exit;
  end;

  InputInterval.a := left_read(InterpolNumBoxXLeft_General.Value.ToString);
  InputInterval.b := left_read(InterpolNumBoxXRight_General.Value.ToString);
  iends_to_strings(InputInterval, inL, inR);
  ComputeInterpolatedIntervalValue(InputInterval, PointsX_General, Coefficients_General, InterpolResult);
  iends_to_strings(InterpolResult, outL, outR);
  Results_General.AddItem('f(['+ inL + '; ' + inR + ']) = [' + outL + '; ' + outR + ']   Szerokość: ' + int_width(InterpolResult).ToString, nil);
  InterpolNumBoxXLeft_General.Value := 0;
  InterpolNumBoxXRight_General.Value := 0;
end;

end.
