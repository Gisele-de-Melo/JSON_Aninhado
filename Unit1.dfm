object Form1: TForm1
  Left = 0
  Top = 0
  BorderStyle = bsSizeToolWin
  Caption = 'JSON Aninhado'
  ClientHeight = 441
  ClientWidth = 438
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 15
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 145
    Height = 49
    Caption = 'Criar JSON Aninhado'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 159
    Top = 8
    Width = 130
    Height = 49
    Caption = 'Atualizar Endere'#231'o'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 295
    Top = 8
    Width = 130
    Height = 49
    Caption = 'Ler dados o pedido'
    TabOrder = 2
    OnClick = Button3Click
  end
  object Memo1: TMemo
    Left = 8
    Top = 63
    Width = 417
    Height = 362
    TabOrder = 3
  end
end
