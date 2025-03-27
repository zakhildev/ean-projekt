object MainWindow: TMainWindow
  Left = 0
  Top = 0
  Caption = 'Zadanie 2 - Wielomian Interpolacyjny Newtona'
  ClientHeight = 334
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object PunktyLabel: TLabel
    Left = 8
    Top = 32
    Width = 37
    Height = 15
    Caption = 'Punkty'
  end
  object NewXLabel: TLabel
    Left = 239
    Top = 59
    Width = 13
    Height = 15
    Caption = 'X: '
  end
  object NewYLabel: TLabel
    Left = 239
    Top = 83
    Width = 13
    Height = 15
    Caption = 'Y: '
  end
  object OutLabel: TLabel
    Left = 239
    Top = 163
    Width = 189
    Height = 15
    Caption = 'Obliczony wielomian interpolacyjny'
  end
  object InputTypeRadioGroup: TRadioGroup
    Left = 8
    Top = 221
    Width = 608
    Height = 105
    Caption = 'Wyb'#243'r typu danych wej'#347'ciowych'
    ItemIndex = 0
    Items.Strings = (
      'Libczy rzeczywiste'
      'Arytmetyka przedzia'#322'owa (Liczby)'
      'Arytmetyka przedzia'#322'owa (Przedzia'#322'y)')
    TabOrder = 0
  end
  object AuthorText: TStaticText
    Left = 8
    Top = 8
    Width = 165
    Height = 19
    Caption = 'Piotr Blecharski 164306, gr. 107'
    TabOrder = 1
  end
  object foc: TListBox
    Left = 8
    Top = 49
    Width = 225
    Height = 128
    ItemHeight = 15
    TabOrder = 2
  end
  object Button1: TButton
    Left = 239
    Top = 109
    Width = 140
    Height = 25
    Caption = 'Dodaj punkt'
    TabOrder = 3
  end
  object Button2: TButton
    Left = 8
    Top = 183
    Width = 225
    Height = 25
    Caption = 'Usu'#324' wybrany punkt'
    TabOrder = 4
  end
  object Edit1: TEdit
    Left = 258
    Top = 54
    Width = 121
    Height = 23
    TabOrder = 5
    TextHint = '6'
  end
  object Edit2: TEdit
    Left = 258
    Top = 80
    Width = 121
    Height = 23
    TabOrder = 6
    TextHint = '9'
  end
  object Edit3: TEdit
    Left = 239
    Top = 184
    Width = 377
    Height = 23
    ReadOnly = True
    TabOrder = 7
  end
end
