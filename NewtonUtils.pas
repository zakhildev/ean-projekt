unit NewtonUtils;

interface

uses
  IntervalArithmetic32and64, Dialogs, SysUtils;

type
  TExtendedArray = array of Extended;
  TIntervalArray = array of Interval;
  PExtedned = ^Extended;
  procedure NewtonExtended(x, y: TExtendedArray; var coefficients: TExtendedArray);
  procedure NewtonInterval(x, y: TIntervalArray; var coefficients: TIntervalArray);
  procedure ComputeInterpolatedExtendedValue(x: Extended; nodes, coeffs: TExtendedArray; out output: Extended);
  procedure ComputeInterpolatedIntervalValue(x: Interval; nodes, coeffs: TIntervalArray; out output: Interval);

implementation

procedure NewtonExtended(x, y: TExtendedArray; var coefficients: TExtendedArray);
var
  n, i, j: Integer;
  dividedDifferences: array of TExtendedArray;
begin
  n := Length(x);
  SetLength(dividedDifferences, n, n);
  SetLength(coefficients, n);

  // Wype�nienie pierwszej kolumny r�nic dzielonych warto�ciami y
  for i := 0 to n - 1 do
    dividedDifferences[i, 0] := y[i];

  // Obliczanie r�nic dzielonych
  for j := 1 to n - 1 do
    for i := 0 to n - j - 1 do
      dividedDifferences[i, j] := (dividedDifferences[i + 1, j - 1] - dividedDifferences[i, j - 1]) / (x[i + j] - x[i]);

  // Wsp�czynniki wielomianu Newtona
  for i := 0 to n - 1 do
    coefficients[i] := dividedDifferences[0, i];
end;

procedure NewtonInterval(x, y: TIntervalArray; var coefficients: TIntervalArray);
var
  n, i, j: Integer;
  dividedDifferences: array of TIntervalArray;
begin
  try
    n := Length(x);
    SetLength(dividedDifferences, n, n);
    SetLength(coefficients, n);

    // Wype�nienie pierwszej kolumny r�nic dzielonych warto�ciami y
    for i := 0 to n - 1 do
      dividedDifferences[i, 0] := y[i];

    // Obliczanie r�nic dzielonych
    for j := 1 to n - 1 do
      for i := 0 to n - j - 1 do
        dividedDifferences[i, j] := IDiv(ISub(dividedDifferences[i + 1, j - 1], dividedDifferences[i, j - 1]),
                                         ISub(x[i + j], x[i]));

    // Wsp�czynniki wielomianu Newtona
    for i := 0 to n - 1 do
      coefficients[i] := dividedDifferences[0, i];
  except
    on EZeroDivide do
    begin
      MessageDlg('B��d! Dzielenie przez przedzia� zawieraj�cy zero.', mtError, [mbOk], 0, mbOk);
      Exit;
    end;
  end;
end;

procedure ComputeInterpolatedExtendedValue(x: Extended; nodes, coeffs: TExtendedArray; out output: Extended);
begin
  if (Length(coeffs) = 0) or (Length(nodes) < Length(coeffs)) then
  begin
    MessageDlg('Nie mo�na obliczy� warto�ci interpolowanej � niepoprawne dane wej�ciowe!', mtError, [mbOK], 0);
    Exit;
  end;

  output := coeffs[0];
  for var i := 1 to High(coeffs) do
  begin
    var product: Extended := 1.0;
    for var j := 0 to i - 1 do
      product := product * (x - nodes[j]);
    output := output + coeffs[i] * product;
  end;
end;

procedure ComputeInterpolatedIntervalValue(x: Interval; nodes, coeffs: TIntervalArray; out output: Interval);
var
  InterpolResult: Interval;
begin
  if (Length(coeffs) <= 0) or (Length(nodes) < Length(coeffs)) then
  begin
    MessageDlg('Nie mo�na obliczcy� warto�ci interpolowanej, gdy nie obliczono wsp�czynnik�w!', mtError, [mbOK], 0, mbOK);
    Exit;
  end;

  output := coeffs[0];
  for var i := 1 to High(coeffs) do
  begin
    var product: Interval := int_read('1');
    for var j := 0 to i - 1 do
      product := IMul(product, ISub(x, nodes[j]));
    output := IAdd(output, IMul(coeffs[i], product));
  end;
end;

end.
