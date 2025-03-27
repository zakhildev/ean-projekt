unit NewtonUtils;

interface

uses
  IntervalArithmetic32and64;

type
  TExtendedArray = array of Extended;
  TIntervalArray = array of Interval;

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

procedure NewtonUnitIntervals(x, y: TIntervalArray; var coefficients: TIntervalArray);
var
  n, i, j: Integer;
  dividedDifferences: array of TIntervalArray;
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
      dividedDifferences[i, j] := IDiv(ISub(dividedDifferences[i + 1, j - 1], dividedDifferences[i, j - 1]),
                                       ISub(x[i + j], x[i]));

  // Wsp�czynniki wielomianu Newtona
  for i := 0 to n - 1 do
    coefficients[i] := dividedDifferences[0, i];
end;

procedure NewtonGeneralIntervals(x, y: TIntervalArray; var coefficients: TIntervalArray);
var
  n, i, j: Integer;
  dividedDifferences: array of array of Interval;
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
      dividedDifferences[i, j] := IDiv(ISub(dividedDifferences[i + 1, j - 1], dividedDifferences[i, j - 1]),
                                       ISub(x[i + j], x[i]));

  // Wsp�czynniki wielomianu Newtona
  for i := 0 to n - 1 do
    coefficients[i] := dividedDifferences[0, i];
end;

end.
