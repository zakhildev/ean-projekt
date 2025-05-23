unit NewtonUtils;

interface

uses
  IntervalArithmetic32and64, Dialogs, SysUtils;

type
  TExtendedArray = array of Extended;
  TIntervalArray = array of Interval;
  procedure NewtonExtended(x, y: TExtendedArray; out coefficients: TExtendedArray; out status: Integer);
  procedure NewtonInterval(x, y: TIntervalArray; out coefficients: TIntervalArray; out status: Integer);
  procedure ComputeInterpolatedExtendedValue(x: Extended; nodes, coeffs: TExtendedArray; out output: Extended; out status: Integer);
  procedure ComputeInterpolatedIntervalValue(x: Interval; nodes, coeffs: TIntervalArray; out output: Interval; out status: Integer);

implementation

procedure NewtonExtended(x, y: TExtendedArray; out coefficients: TExtendedArray; out status: Integer);
var
  n, i, j: Integer;
  dividedDifferences: array of TExtendedArray;
begin
  n := Length(x);
  SetLength(dividedDifferences, n, n);
  SetLength(coefficients, n);

  // Wypelnienie pierwszej kolumny roznic dzielonych wartosciami y
  for i := 0 to n - 1 do
    dividedDifferences[i, 0] := y[i];

  // Obliczanie roznic dzielonych
  for j := 1 to n - 1 do
    for i := 0 to n - j - 1 do
      dividedDifferences[i, j] := (dividedDifferences[i + 1, j - 1] - dividedDifferences[i, j - 1]) / (x[i + j] - x[i]);

  // Wspolczynniki wielomianu Newtona
  for i := 0 to n - 1 do
    coefficients[i] := dividedDifferences[0, i];

  status := 0;
end;

procedure NewtonInterval(x, y: TIntervalArray; out coefficients: TIntervalArray; out status: Integer);
var
  n, i, j: Integer;
  dividedDifferences: array of TIntervalArray;
begin
  try
    n := Length(x);
    SetLength(dividedDifferences, n, n);
    SetLength(coefficients, n);

    // Wypelnienie pierwszej kolumny roznic dzielonych wartosciami y
    for i := 0 to n - 1 do
      dividedDifferences[i, 0] := y[i];

    // Obliczanie roznic dzielonych
    for j := 1 to n - 1 do
      for i := 0 to n - j - 1 do
        dividedDifferences[i, j] := IDiv(ISub(dividedDifferences[i + 1, j - 1], dividedDifferences[i, j - 1]),
                                         ISub(x[i + j], x[i]));

    // Wspolczynniki wielomianu Newtona
    for i := 0 to n - 1 do
      coefficients[i] := dividedDifferences[0, i];
  except
    on EZeroDivide do
    begin
      MessageDlg('Blad! Dzielenie przez przedzial zawierajacy zero.', mtError, [mbOk], 0, mbOk);
      Exit;
    end;
  end;

  status := 0;
end;

procedure ComputeInterpolatedExtendedValue(x: Extended; nodes, coeffs: TExtendedArray; out output: Extended; out status: Integer);
var
  product: Extended;
begin
  if (Length(coeffs) = 0) or (Length(nodes) < Length(coeffs)) then
  begin
    MessageDlg('Nie mozna obliczyc wartosci interpolowanej — niepoprawne dane wejsciowe!', mtError, [mbOK], 0);
    Exit;
  end;

  output := coeffs[0];
  for var i := 1 to High(coeffs) do
  begin
    product := 1.0;
    for var j := 0 to i - 1 do
      product := product * (x - nodes[j]);
    output := output + coeffs[i] * product;
  end;
end;

procedure ComputeInterpolatedIntervalValue(x: Interval; nodes, coeffs: TIntervalArray; out output: Interval; out status: Integer);
var
  InterpolResult, product: Interval;
begin
  if (Length(coeffs) <= 0) or (Length(nodes) < Length(coeffs)) then
  begin
    MessageDlg('Nie mozna obliczcyc wartosci interpolowanej, gdy nie obliczono wspolczynników!', mtError, [mbOK], 0, mbOK);
    Exit;
  end;

  output := coeffs[0];
  for var i := 1 to High(coeffs) do
  begin
    product := int_read('1');
    for var j := 0 to i - 1 do
      product := IMul(product, ISub(x, nodes[j]));
    output := IAdd(output, IMul(coeffs[i], product));
  end;

  status := 0;
end;

end.
